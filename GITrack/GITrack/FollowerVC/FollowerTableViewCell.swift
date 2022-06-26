//
//  FollowerTableViewCell.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/27.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var followerIDLabel: UILabel!
    @IBOutlet weak var followerAvatarImage: UIImageView!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var followerCommitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
