//
//  MediaTableViewCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/20/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class MediaCell: BaseTableCell {
    
//    var loadedImage:UIImage?{
//        didSet{
//            print("didset")
//        }
//    }
    var mediaImageView: UIImageView = {
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
        self.addSubview(self.mediaImageView)
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
        let viewDict = ["mediaImageView":mediaImageView, "usernameAndCaptionLabel":usernameAndCaptionLabel, "commentLabel":commentLabel]
        myAddConstraint("H:|[mediaImageView]|", view: mediaImageView, viewsDictionary: viewDict)
        myAddConstraint("V:|[mediaImageView(\(viewWidth))]", view: mediaImageView, viewsDictionary: viewDict)
        myAddConstraint("H:|[usernameAndCaptionLabel]|", view: usernameAndCaptionLabel, viewsDictionary: viewDict)
        myAddConstraint("V:[mediaImageView]-0-[usernameAndCaptionLabel]", view: usernameAndCaptionLabel, viewsDictionary: viewDict)
        myAddConstraint("H:|[commentLabel]|", view: commentLabel, viewsDictionary: viewDict)
        myAddConstraint("V:[usernameAndCaptionLabel]-0-[commentLabel]", view: commentLabel, viewsDictionary: viewDict)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}



class BaseTableCell:UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //print("UITableViewCell Init")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        //print("UITableViewCell aDecoder Init")
        super.init(coder: aDecoder)
        setupView()
    }
    func setupView(){}
}


























