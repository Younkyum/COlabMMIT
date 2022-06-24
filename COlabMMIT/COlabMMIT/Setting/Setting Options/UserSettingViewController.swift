//
//  UserSettingViewController.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/02.
//

import UIKit

class UserSettingViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmButtonPushed(_ sender: Any) {
        
        if userNameField.text?.count ?? 0 > 1 {
            getUserIsReal(user: userNameField.text!)
            
        } else {
            self.showErrorAlert(with: "Please Write ID", title: "Error")
        }
        
    }
    
    func getUserIsReal(user: String) {
        let booksUrlStr = "https://api.github.com/users/\(user)/events"
        
        // Code Input Point #1
         guard let url = URL(string: booksUrlStr) else {
             fatalError("Invalid URL")
         }
         
         let session = URLSession.shared
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error { // 에러가 발생함
                 self.showErrorAlert(with: error.localizedDescription)
                 print("error1")
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse else {
                 self.showErrorAlert(with: "Invalid Response") // response가 없음
                 return
             }
             
             guard (200...299).contains(httpResponse.statusCode) else {
                 self.showErrorAlert(with: "\(httpResponse.statusCode)") // status code 값 비교
                 return
             }
             
             guard let data = data else { // 데이터 동기화 안될경우 오류 발생
                 fatalError("Invalid Data")
             }
             DispatchQueue.main.async {
                 UserDefaults.standard.set(self.userNameField.text!, forKey: userNameKey)
                 userName = self.userNameField.text!
                 self.navigationController?.popViewController(animated: true)
             }
             
         }
         task.resume()
        
        
        
    }

}
