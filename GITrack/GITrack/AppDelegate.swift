//
//  AppDelegate.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/24.
//

import UIKit

var userInfo = UserUse(userID: "userID", userName: "userName", todayCommit: -1, followers: -1, followings: -1, createdAt: "createdAt", avatarURL: "avavatarURL")
let userkey = "userkey"
let initialkey = "initialkey"
var user = "user"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        if !UserDefaults.standard.bool(forKey: initialkey) {
            UserDefaults.standard.set(true, forKey: initialkey)
            UserDefaults.standard.set("Younkyum", forKey: userkey)
            user = "Younkyum"
        }

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

