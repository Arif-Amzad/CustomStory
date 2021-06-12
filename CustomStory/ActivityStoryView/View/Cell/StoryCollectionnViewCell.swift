//
//  StoryCollectionnViewCell.swift
//  CustomStory
//
//  Created by Arif Amzad on 11/6/21.
//

import UIKit

class StoryCollectionnViewCell: UICollectionViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var storyImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
        self.avatarImageView.layer.borderColor = UIColor.systemBlue.cgColor
        self.avatarImageView.layer.borderWidth = 3
        self.storyImageView.layer.cornerRadius = 8
    }

}
