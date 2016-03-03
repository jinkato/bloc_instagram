//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/20/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

//    var mediaItem : Media;
    var mediaImageView: UIImageView
    var usernameAndCaptionLabel: UILabel
    var commentLabel: UILabel
    
    static var lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
    static var boldFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 11)!
    let usernameLabelGray: UIColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    static var commentLabelGray: UIColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    static var linkColor: UIColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
    var paragraphStyle: NSParagraphStyle?
    var mutableParagraphStyle: NSMutableParagraphStyle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        print("regular init")
        // Initialization code
        self.mediaImageView = UIImageView()
        self.usernameAndCaptionLabel = UILabel()
        self.commentLabel = UILabel()
        self.mutableParagraphStyle = NSMutableParagraphStyle()
        //Super Init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Text Style
//        self.usernameAndCaptionLabel.numberOfLines = 0
//        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
//        self.commentLabel.numberOfLines = 0
//        self.backgroundColor = usernameLabelGray
//        // Add Subview
//        self.contentView.addSubview(self.mediaImageView)
//        self.contentView.addSubview(self.usernameAndCaptionLabel)
//        self.contentView.addSubview(self.commentLabel)
//        // Text Style
//        self.mutableParagraphStyle.headIndent = 20.0
//        self.mutableParagraphStyle.firstLineHeadIndent = 20.0
//        self.mutableParagraphStyle.tailIndent = -20.0
//        self.mutableParagraphStyle.paragraphSpacingBefore = 5
//        paragraphStyle = mutableParagraphStyle
//        
//        usernameAndCaptionString()
    }
    
    func usernameAndCaptionString(){
//        print("usernameAndCaptionString")
        // Attributes
//        var usernameFontSize: CGFloat = 15
//        var lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
//        let myAttributes = [
//            NSFontAttributeName : lightFont,
//            NSForegroundColorAttributeName : UIColor.whiteColor()
//        ]
//        // Text
//        var baseString: String = ((mediaItem.user?.userName)! as String) + " " + (mediaItem.caption as String)
//        
//        var mutableUsernameAndCaptionString = NSMutableAttributedString( string: baseString, attributes: myAttributes )
//        print(baseString)
    }

    required init?(coder aDecoder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        self.mediaImageView = UIImageView()
        self.usernameAndCaptionLabel = UILabel(frame: CGRectMake(0, 50, 200, 21))
        self.commentLabel = UILabel(frame: CGRectMake(0, 100, 200, 21))
        self.mutableParagraphStyle = NSMutableParagraphStyle()
        super.init(coder: aDecoder)
        // Text Style
//        self.usernameAndCaptionLabel.numberOfLines = 0
//        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
//        self.commentLabel.numberOfLines = 0
//        self.backgroundColor = usernameLabelGray
        // Add Subview
        self.addSubview(self.usernameAndCaptionLabel)
//        self.addSubview(self.mediaImageView)
//        self.contentView.addSubview(self.usernameAndCaptionLabel)
        self.contentView.addSubview(self.commentLabel)
        // Text Style
        self.mutableParagraphStyle.headIndent = 20.0
        self.mutableParagraphStyle.firstLineHeadIndent = 20.0
        self.mutableParagraphStyle.tailIndent = -20.0
        self.mutableParagraphStyle.paragraphSpacingBefore = 5
        paragraphStyle = mutableParagraphStyle
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}






