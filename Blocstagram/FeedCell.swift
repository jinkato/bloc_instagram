//
//  FeedCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/15/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

class FeedCell:BaseCell {
    var content:String?{
        didSet{
            //print("did set")
        }
    }
    let mainImageView = UIImageView()
    let nameLable:UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.blackColor()
        let font = UIFont.systemFontOfSize(17.0)
        label.font = font
        label.numberOfLines = 0
        label.backgroundColor = UIColor.blueColor()
        label.sizeToFit()
        return label
        }()
    let commentLable:UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.yellowColor()
        let font = UIFont.systemFontOfSize(17.0)
        label.font = font
        label.numberOfLines = 0
        label.backgroundColor = UIColor.grayColor()
        label.sizeToFit()
        return label
        }()
    override func setupView() {
        print("collectionview")
        let viewDict = ["mainImageView":mainImageView, "nameLable":nameLable, "commentLable":commentLable]
        addSubview(mainImageView)
        print(mainImageView.image?.size.height)
        addSubview(nameLable)
        myAddConstraint("H:|[nameLable]|", view: nameLable, viewsDictionary: viewDict)
        myAddConstraint("V:[mainImageView]-[nameLable(50)]", view: nameLable, viewsDictionary: viewDict)
        addSubview(commentLable)
        myAddConstraint("H:|-0-[commentLable]-0-|", view: commentLable, viewsDictionary: viewDict)
        myAddConstraint("V:[nameLable]-0-[commentLable]", view: commentLable, viewsDictionary: viewDict)
    }
}

class BaseCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){}
}