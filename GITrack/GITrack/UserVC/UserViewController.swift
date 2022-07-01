//
//  UserViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/25.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var todayCommitLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var userFollowerLabel: UILabel!
    @IBOutlet weak var userCreatedAtLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        completeView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeView()
    }
    
    func completeView() {
        user = UserDefaults.standard.string(forKey: userkey)!
        userInfo = getUserAPI(user: user)
        
        imageDownload(url: URL(string: userInfo.avatarURL)!)
        
        changeDate()
        
        todayCommitLabel.text = String(getTodayCommit(user: user))
        userIdLabel.text = userInfo.userID
        userNameLabel.text = userInfo.userName
        userFollowingLabel.text = String(userInfo.followings)
        userFollowerLabel.text = String(userInfo.followers)
        userCreatedAtLabel.text = userInfo.createdAt
        
    }
    
    
    
    func changeDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let a = formatter.date(from: userInfo.createdAt)!
        formatter.dateFormat = "yyyy-MM-dd"
        userInfo.createdAt = formatter.string(from: Date(timeInterval: 32400, since: a))
    }
    
    func imageDownload(url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }

            DispatchQueue.main.async() {[weak self] in

                self?.userAvatarImage.image = image
            }
        }.resume()
    }
    
    @IBAction func reloadButtonPush(_ sender: UIButton) {
        userInfo = getUserAPI(user: user)
        completeView()
    }
    
    @IBAction func changeButtonPush(_ sender: Any) {
        
    }
    
}
