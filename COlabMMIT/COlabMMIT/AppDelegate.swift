//
//  AppDelegate.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/01.
//

import UIKit

// MARK: - UserDefaults Key
let initialKey = "initialKey"
let userNameKey = "userNameKey"
let followerKey = "followerKey"

// MARK: - Master Values
var userName = "user name"
var userCommitCount = 0
var followerNames: [Any] = ["Younkyum"]
var followerCommitCount: [Int] = [-1]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 처음 실행되었을 때 설정 만들기
        if !UserDefaults.standard.bool(forKey: initialKey) {
            UserDefaults.standard.set(true, forKey: initialKey)
            UserDefaults.standard.set("Github", forKey: userNameKey)
            UserDefaults.standard.set(["Younkyum"], forKey: followerKey)
            
            userName = "Github"
            followerNames = ["Younkyum"]
            
        } else {
            userName = UserDefaults.standard.string(forKey: userNameKey)!
            followerNames = UserDefaults.standard.array(forKey: followerKey)!
        }
        
        userCommitCount = getApi(user: userName)
        
        if followerNames.count >= 1 {
            for follower in followerNames {
                if followerCommitCount[0] == -1 {
                    followerCommitCount[0] = getApi(user: follower as! String)
                } else {
                    followerCommitCount.append(getApi(user: follower as! String))
                }
            }
        }
        
        // 앱 처음 update시 실행됨 (api)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

