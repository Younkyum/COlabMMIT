//
//  API-Model.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/01.
//

import Foundation
import UserNotifications


struct Event: Codable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repo
    let payload: Payload
    let is_public: Bool
    let created_at: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case actor
        case repo
        case payload
        case is_public = "public"
        case created_at
    }
}

struct Actor: Codable {
    let id: Int
    let login: String
    let display_login: String
    let gravatar_id: String
    let url: String
    let avatar_url: String

}

struct Repo: Codable {
    let id: Int
    let name: String
    let url: String
}

struct Payload: Codable {
    let push_id: Int?
    let size: Int?
    let distinct_size: Int?
    let ref: String?
    let head: String?
    let before: String?
    let commits: [Commits]?
}

struct Commits: Codable {
    let sha: String
    let author: Author
    let message: String
    let distinct: Bool
    let url: String
}

struct Author: Codable {
    let email: String
    let name: String
}


// Event user
func getApi(user: String) -> Int {
    let booksUrlStr = "https://api.github.com/users/\(user)/events"
    var returnEvent = [Event]()
    var run = true
    
    // Code Input Point #1
     guard let url = URL(string: booksUrlStr) else {
         fatalError("Invalid URL")
     }
     
     let session = URLSession.shared
     let task = session.dataTask(with: url) { (data, response, error) in
         if let error = error { // 에러가 발생함
             print(error)
             return
         }
         
         guard let httpResponse = response as? HTTPURLResponse else {
             return
         }
         
         guard (200...299).contains(httpResponse.statusCode) else {
             return
         }
         
         guard let data = data else { // 데이터 동기화 안될경우 오류 발생
             fatalError("Invalid Data")
         }
         
         do {
             let decoder = JSONDecoder()
             decoder.dateDecodingStrategy = .iso8601
             
             
             
             let eventlist = try decoder.decode([Event].self, from: data)
             returnEvent = eventlist
             run = false
             

         } catch {
             print(error)
         }
     }
     task.resume()
    
    while run {
        
    }
    
    let counter = countTodayCommits(list: returnEvent)
    print(user + " " + String(counter))
    return counter
}

func countTodayCommits(list:[Event]) -> Int {
    var totalCount = 0
    let today = today()
    for i in list {
        print(i.type, returnToday(created: i.created_at))
        if returnToday(created: i.created_at).contains(today) && i.type == "PushEvent" {
            totalCount += 1
        }
    }
    return totalCount
}

// String 형태로 오늘 날짜 출력
func today() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let now = formatter.string(from: Date())
    return now
}

func returnToday(created: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let a = formatter.date(from: created)!
    let date = formatter.string(from: Date(timeInterval: 32400, since: a))
    print(date)
    return date
}
