//
//  FollowerViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/26.
//

import UIKit

class FollowerViewController: UIViewController {

    
    @IBOutlet weak var followerTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followerTableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTableViewCell")
        // Do any additional setup after loading the view.
    }
    


}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(followerList)
        return followerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as? FollowerTableViewCell else { return UITableViewCell() }
        
        cell.followerCommitLabel.text = String(followerCommit[indexPath.row])
        cell.followerIDLabel.text = followerList[indexPath.row]
        cell.followerAvatarImage.image = followerImage[indexPath.row]
        cell.plusImage.alpha = 0
        
        if followerList[indexPath.row] == "plus" {
            cell.followerIDLabel.alpha = 0
            cell.followerCommitLabel.alpha = 0
            cell.followerAvatarImage.alpha = 0
            cell.plusImage.alpha = 1
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}
