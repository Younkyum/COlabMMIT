//
//  FollowerDetailViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/29.
//

import UIKit

class FollowerDetailViewController: UIViewController {
    
    var userName = ""
    var userCommit = 0
    var getUserImage = UIImage(systemName: "person")
    
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getFollowerData(user: userName)
        commitLabel.text = String(userCommit)
        userImage.image = getUserImage
    }
    
    func getFollowerData(user: String) {
        let user = getUserAPI(user: userName)
        
        createdAtLabel.text = user.createdAt
        userIDLabel.text = user.userID
        userNameLabel.text = user.userName
        followerLabel.text = String(user.followers)
        followingLabel.text = String(user.followings)
    }
    
 

}
