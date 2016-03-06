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
    
    let lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
    let boldFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 11)!
    let usernameLabelGray: UIColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    let commentLabelGray: UIColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    let linkColor: UIColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
    var mutableParagraphStyle: NSMutableParagraphStyle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        print("regular init not called")
        // Initialization code
        self.mediaImageView = UIImageView()
        self.usernameAndCaptionLabel = UILabel()
        self.commentLabel = UILabel()
        self.mutableParagraphStyle = NSMutableParagraphStyle()
        //Super Init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        
        print("custom cell")
       // fatalError("init(coder:) has not been implemented")
        self.mediaImageView = UIImageView()
        //username and caption
        self.usernameAndCaptionLabel = UILabel()
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
        self.usernameAndCaptionLabel.numberOfLines = 0
        self.usernameAndCaptionLabel.lineBreakMode = .ByCharWrapping
        self.commentLabel = UILabel()
//        self.commentLabel.backgroundColor = commentLabelGray
        self.mutableParagraphStyle = NSMutableParagraphStyle()
//        self.mutableParagraphStyle.headIndent = 20.0
//        self.mutableParagraphStyle.firstLineHeadIndent = 20.0
//        self.mutableParagraphStyle.tailIndent = -20.0
//        self.mutableParagraphStyle.paragraphSpacingBefore = 5
        
        // Init
        super.init(coder: aDecoder)

        // Add Subview
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
//        self.contentView.addSubview(self.commentLabel)
//        self.addSubview(self.mediaImageView)
        
        var items = RandomData.sharedInstance.mediaItems
//        print(items[0].comments.count)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}




























