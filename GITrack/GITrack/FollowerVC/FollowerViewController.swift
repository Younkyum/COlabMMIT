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

        // Do any additional setup after loading the view.
    }
    


}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = UserDefaults.standard.array(forKey: followerkey)!
        
        return list.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = UserDefaults.standard.array(forKey: followerkey)!
        switch indexPath.row {
        case list.count - 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlusTableViewCell", for: indexPath) as? PlusTableViewCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as? FollowerTableViewCell else { return UITableViewCell() }
            
            cell.userIDLabel.text = list[indexPath.row + 1] as! String
            cell.commitCountLabel.text = String(getTodayCommit(user: cell.userIDLabel.text!))
            /*
            var request = URLRequest(url: " ")
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

                    cell.userFaceImage.image = image
                }
            }.resume()
            */
            return cell
        }
    }
    
    
}
