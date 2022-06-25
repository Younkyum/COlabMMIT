//
//  APICaller.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/25.
//

import UIKit

func getUserAPI(user: String) -> UserUse {
    let userUrl = "https://api.github.com/users/\(user)"
    var outValue = UserUse(userID: "userID", userName: "userName", todayCommit: 0, followers: 0, followings: 0, createdAt: "2022-04-07T07:04:31Z", avatarURL: "avatarURL")
    var run = true
    
    guard let url = URL(string: userUrl) else {
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

            let rawValue = try decoder.decode(User.self, from: data)
            
            
            outValue.userID = rawValue.login
            outValue.userName = rawValue.name ?? rawValue.login
            outValue.followers = rawValue.followers
            outValue.followings = rawValue.following
            outValue.createdAt = rawValue.created_at
            outValue.avatarURL = rawValue.avatar_url
            
            
            run = false
            

        } catch {
            print(error)
        }
    }
    task.resume()
    
    while run {
        
    }
    
    return outValue
}


func getTodayCommit(user: String) -> Int {
    var run = true
    let userUrl = "https://api.github.com/users/\(user)/events"
    var userRepos = [Event(type: "type", created_at: "created_at")]

    guard let url = URL(string: userUrl) else {
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

            
            userRepos = try decoder.decode([Event].self, from: data)

            
            run = false

        } catch {
            print(error)
        }
    }
    task.resume()
    while run {
    }
    
    let today = todayToString()
    var todaySum = 0
    
    for userEvent in userRepos {
        print(changeDateForCommit(date: userEvent.created_at))
        if today <= changeDateForCommit(date: userEvent.created_at) {
            if userEvent.type == "CreateEvent" || userEvent.type == "PushEvent" {
                todaySum += 1
            }
        } else {
            break
        }
    }
    
    return todaySum
}
/*

func commitCounter(repo: String, user: String) -> Int {
    var run = true
    let repoURL = "https://api.github.com/repos/\(user)/\(repo)/commits"
    var commits = [repoCommit(commit: Commit(author: Author(date: "today")))]
    
    guard let url = URL(string: repoURL) else {
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

            
            commits = try decoder.decode([repoCommit].self, from: data)
            run = false

        } catch {
            print(error)
        }
    }
    task.resume()
    while run {
    }
    
    
    var sum = 0
    let today = todayToString()
    
    for x in commits {
        if today == changeDateForCommit(date: x.commit.author.date) {
            sum += 1
        } else {
            break
        }
    }
    return sum
}
 */

func changeDateForCommit(date: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let a = formatter.date(from: date)!
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date(timeInterval: 32400, since: a))
}


func todayToString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date(timeIntervalSinceNow: 0))
}


