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
            outValue.userName = rawValue.name
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


