//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/20/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class FeedCell: BaseTableCell {
    
    var feed:Feed?{
        didSet{
            let fullName = feed?.user?.fullName as! String
            let caption = feed?.caption as! String
            let userCaptionString = "\(fullName) \(caption)"
            let fullNameCount:Int = fullName.characters.count
            let usernameCaptionAttribute = NSMutableAttributedString(string: userCaptionString, attributes: [NSFontAttributeName: Fonts.lightFont])
            usernameCaptionAttribute.addAttribute(NSFontAttributeName, value: Fonts.boldFont, range: NSRange(location:0,length:fullNameCount))
            usernameCaptionAttribute.addAttribute(NSForegroundColorAttributeName, value: Fonts.linkColor, range: NSRange(location:0,length:fullNameCount))
            usernameCaptionAttribute.addAttribute(NSKernAttributeName, value: 2, range: NSRange(location:0,length:fullNameCount))
            self.usernameAndCaptionLabel.text = userCaptionString
            self.usernameAndCaptionLabel.attributedText = usernameCaptionAttribute
        }
    }
    var commentArray:[Comment]?{
        didSet{
            self.commentLabel.text = Utils.concatenateCommentArray(commentArray!)
            self.commentLabel.font = Fonts.lightFont
            self.commentLabel.attributedText = Utils.commentAttribute(commentArray!)
        }
    }
    var mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blackColor()
        return imageView
    }()
    var usernameAndCaptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        return label
    }()
    var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return label
    }()
    
    // ------------------------------------------------------------------------------------------ //
    
    override func setupView(){
        let viewWidth = UIScreen.mainScreen().bounds.width
        self.addSubview(self.mainImageView)
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
        let viewDict = ["mainImageView":mainImageView, "usernameAndCaptionLabel":usernameAndCaptionLabel, "commentLabel":commentLabel]
        myAddConstraint("H:|[mainImageView]|", view: mainImageView, viewsDictionary: viewDict)
        myAddConstraint("V:|[mainImageView(\(viewWidth))]", view: mainImageView, viewsDictionary: viewDict)
        myAddConstraint("H:|[usernameAndCaptionLabel]|", view: usernameAndCaptionLabel, viewsDictionary: viewDict)
        myAddConstraint("V:[mainImageView]-0-[usernameAndCaptionLabel]", view: usernameAndCaptionLabel, viewsDictionary: viewDict)
        myAddConstraint("H:|[commentLabel]|", view: commentLabel, viewsDictionary: viewDict)
        myAddConstraint("V:[usernameAndCaptionLabel]-0-[commentLabel]", view: commentLabel, viewsDictionary: viewDict)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // ------------------------------------------------------------------------------------------ //
    
}














