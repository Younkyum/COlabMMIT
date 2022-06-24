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
    
    override func viewWillAppear(_ animated: Bool) {
        userNameLabel.text = userName
        userCommitCount = getApi(user: userName)
        userCommitCountLabel.text = String(userCommitCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
        followerCollectionView.backgroundColor = .white
        followerCollectionView.register(UINib(nibName: "FollowerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FollowerCollectionViewCell")
        
        
        userCommitCountLabel.text = String(userCommitCount)
        print(userCommitCount)
        userNameLabel.text = userName
        followingCountLabel.text = "Following " + String(followerCommitCount.count)
        
    }
    // MARK: - LayOut
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 1.83, height: halfWidth * 0.45)
        self.followerCollectionView.collectionViewLayout = flowLayout
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
