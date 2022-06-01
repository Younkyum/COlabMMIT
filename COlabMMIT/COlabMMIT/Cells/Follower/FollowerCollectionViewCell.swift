//
//  FollowerCollectionViewCell.swift
//  COlabMMIT
//
//  Created by Jin younkyum on 2022/06/01.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var todayCommitLabel: UILabel!  // Today Commit Label
    @IBOutlet weak var commitCount: UILabel!  // Commit Label
    @IBOutlet weak var userName: UILabel!  // User Label
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
