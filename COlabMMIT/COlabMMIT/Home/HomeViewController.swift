//
//  HomeViewController.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/01.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOulets
    @IBOutlet weak var todayCommitLabel: UILabel!
    @IBOutlet weak var userCommitCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    
    // MARK: - View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        followerCollectionView.register(UINib(nibName: "FollowerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FollowerCollectionViewCell")
        
        
        userCommitCountLabel.text = String(userCommitCount)
        userNameLabel.text = userName
        
    }
    
    // MARK: - API Methods

}

// MARK: - Extension - CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followerCommitCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowerCollectionViewCell", for: indexPath) as? FollowerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.userName.text = followerNames[indexPath.row] as? String
        cell.commitCount.text = String(followerCommitCount[indexPath.row])
        
        return cell
    }
}
