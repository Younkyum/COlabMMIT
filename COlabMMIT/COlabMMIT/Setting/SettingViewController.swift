//
//  SettingViewController.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/01.
//

import UIKit

class SettingViewController: UIViewController {

    let settingOptions = ["User", "Notifications", "Themes"]
    
    
    @IBOutlet weak var settingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: .main), forCellReuseIdentifier: "SettingTableViewCell")
    }


}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = settingOptions[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserSettingViewController") as? UserSettingViewController else {return}
            nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            print("notifications")
        case 2:
            print("Themes")
        default:
            print("error occured")
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
