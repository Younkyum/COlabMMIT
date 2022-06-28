//
//  AddNewFollowerViewController.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/28.
//

import UIKit

class AddNewFollowerViewController: UIViewController {

    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var waitIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitIndicator.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmButtonPush(_ sender: Any) {
        getNewFollowerCommit(user: inputField.text!)
    }
    
    
    
    func getNewFollowerCommit(user: String) {
        var run = true
        let userUrl = "https://api.github.com/users/\(user)/events"
        var userRepos = [Event(type: "type", created_at: "created_at")]
        var image = UIImage(systemName: "person")

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
                print(userRepos)
                
                print("image load")

                
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
        
        followerList.insert(user, at: 0)
        followerCommit.insert(todaySum, at: 0)
        image = getAvatar(user: user)
        followerImage.insert(image, at: 0)
        
        UserDefaults.standard.set(followerList, forKey: followerkey)
        print(followerList)
        print(followerCommit)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}
