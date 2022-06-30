//
//  FollowerViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/26.
//

import UIKit

class FollowerViewController: UIViewController {

    
    @IBOutlet weak var followerTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        followerCommit.removeAll()
        followerImage.removeAll()
        for follower in followerList {
            followerCommit.append(getTodayCommit(user: follower))
            followerImage.append(getAvatar(user: follower))
        }
        followerTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.followerTableView.delegate = self
        self.followerTableView.dataSource = self
        
        
        followerTableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTableViewCell")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func reloadbutton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewFollowerViewController") as? AddNewFollowerViewController else {return}
        nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    

}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as? FollowerTableViewCell else { return UITableViewCell() }
        
        
        
        
        cell.followerCommitLabel.text = String(followerCommit[indexPath.row])
        cell.followerIDLabel.text = followerList[indexPath.row]
        cell.followerAvatarImage.image = followerImage[indexPath.row]
        cell.plusImage.alpha = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowerDetailViewController") as? FollowerDetailViewController else {return}
        nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        nextVC.userName = followerList[indexPath.row]
        nextVC.userCommit = followerCommit[indexPath.row]
        nextVC.getUserImage = followerImage[indexPath.row]
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            followerList.remove(at: indexPath.row)
            followerCommit.remove(at: indexPath.row)
            followerImage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            
            UserDefaults.standard.set(followerList, forKey: followerkey)
        }
    }

}

