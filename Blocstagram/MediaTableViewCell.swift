//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/20/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    var mediaImageView: UIImageView
    var usernameAndCaptionLabel: UILabel
    var commentLabel: UILabel
    let usernameLabelGray: UIColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    let commentLabelGray: UIColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        print("regular init not called")
        // Initialization code
        self.mediaImageView = UIImageView()
        self.usernameAndCaptionLabel = UILabel()
        self.commentLabel = UILabel()
        //Super Init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        self.mediaImageView = UIImageView()
        //username and caption
        self.usernameAndCaptionLabel = UILabel()
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
        self.usernameAndCaptionLabel.numberOfLines = 0
        self.usernameAndCaptionLabel.lineBreakMode = .ByCharWrapping
        self.commentLabel = UILabel()
        self.commentLabel.numberOfLines = 0
        self.commentLabel.lineBreakMode = .ByCharWrapping
        self.commentLabel.backgroundColor = commentLabelGray
        // Init
        super.init(coder: aDecoder)
        // Add Subview
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
        self.addSubview(self.mediaImageView)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}




























