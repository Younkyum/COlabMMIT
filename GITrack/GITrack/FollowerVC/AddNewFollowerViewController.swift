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
        
        print("reloaded")
        waitIndicator.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmButtonPush(_ sender: Any) {
        getUserIsReal(user: inputField.text!)
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
                 var list = UserDefaults.standard.stringArray(forKey: followerkey)
                 list?.insert(self.inputField.text!, at: 0)
                 UserDefaults.standard.set(list, forKey: followerkey)
                 print(UserDefaults.standard.string(forKey: followerkey))
                 followerList.insert(user, at: 0)
                 self.navigationController?.popViewController(animated: true)
             }
         }
         task.resume()
        
    }
    
}
