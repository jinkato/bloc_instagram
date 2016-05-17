//
//  CustomCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/4/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    var mediaImageView: UIImageView
    var usernameAndCaptionLabel: UILabel
    var commentLabel: UILabel
    let usernameLabelGray: UIColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    let commentLabelGray: UIColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    
    var heightConstraint: NSLayoutConstraint!
    var widthConstraint:NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        print("init 1")
        // Initialization code
        //image
        self.mediaImageView = UIImageView()
        self.mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        //username
        self.usernameAndCaptionLabel = UILabel(frame: CGRectMake(0, 0, 100, 100))
        self.usernameAndCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
        self.usernameAndCaptionLabel.numberOfLines = 0
        self.usernameAndCaptionLabel.lineBreakMode = .ByCharWrapping
        //comment
        self.commentLabel = UILabel()
        self.commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.commentLabel.numberOfLines = 0
        self.commentLabel.lineBreakMode = .ByCharWrapping
        self.commentLabel.backgroundColor = commentLabelGray
        
        //Super Init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add Subview
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
        self.addSubview(self.mediaImageView)
        
        // Auto Layou
//        let container = UILayoutGuide()
//        self.addLayoutGuide(container)
//        let margins = self.layoutMarginsGuide
//        container.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: 0.0).active = true
//        container.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 0.0).active = true
//        container.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: 0.0).active = true
//        self.mediaImageView.topAnchor.constraintEqualToAnchor(container.topAnchor, constant: 0.0).active = true
//        self.mediaImageView.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0).active = true
//        self.heightConstraint = self.mediaImageView.heightAnchor.constraintEqualToConstant(100.0)
//        self.heightConstraint.active = true
//        self.widthConstraint = self.mediaImageView.widthAnchor.constraintEqualToConstant(100.0)
//        self.widthConstraint.active = true
//        self.usernameAndCaptionLabel.topAnchor.constraintEqualToAnchor(self.mediaImageView.bottomAnchor, constant: 0.0).active = true
//        self.usernameAndCaptionLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
//        self.usernameAndCaptionLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
//        self.commentLabel.topAnchor.constraintEqualToAnchor(self.usernameAndCaptionLabel.bottomAnchor, constant: 0.0).active = true
//        self.commentLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
//        self.commentLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
        
        
        
        
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init 2")
        // fatalError("init(coder:) has not been implemented")
        //image
        self.mediaImageView = UIImageView()
        self.mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        //username
        self.usernameAndCaptionLabel = UILabel(frame: CGRectMake(0, 0, 100, 100))
        self.usernameAndCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray
        self.usernameAndCaptionLabel.numberOfLines = 0
        self.usernameAndCaptionLabel.lineBreakMode = .ByCharWrapping
        //comment
        self.commentLabel = UILabel()
        self.commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.commentLabel.numberOfLines = 0
        self.commentLabel.lineBreakMode = .ByCharWrapping
        self.commentLabel.backgroundColor = commentLabelGray
        // Init
        super.init(coder: aDecoder)
        // Add Subview
        self.addSubview(self.usernameAndCaptionLabel)
        self.addSubview(self.commentLabel)
        self.addSubview(self.mediaImageView)
        
        let container = UILayoutGuide()
        self.addLayoutGuide(container)
        let margins = self.layoutMarginsGuide
        container.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: 0.0).active = true
        container.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 0.0).active = true
        container.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: 0.0).active = true
        self.mediaImageView.topAnchor.constraintEqualToAnchor(container.topAnchor, constant: 0.0).active = true
        self.mediaImageView.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0).active = true
        self.heightConstraint = self.mediaImageView.heightAnchor.constraintEqualToConstant(100.0)
        self.heightConstraint.active = true
        self.widthConstraint = self.mediaImageView.widthAnchor.constraintEqualToConstant(100.0)
        self.widthConstraint.active = true
        self.usernameAndCaptionLabel.topAnchor.constraintEqualToAnchor(self.mediaImageView.bottomAnchor, constant: 0.0).active = true
        self.usernameAndCaptionLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
        self.usernameAndCaptionLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
        self.commentLabel.topAnchor.constraintEqualToAnchor(self.usernameAndCaptionLabel.bottomAnchor, constant: 0.0).active = true
        self.commentLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
        self.commentLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
