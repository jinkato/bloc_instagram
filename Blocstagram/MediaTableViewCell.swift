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
    var heightConstraint: NSLayoutConstraint!
    private var _cellIndex: UInt = 0
    var cellIndex: UInt {
        get {
            return self._cellIndex
        }
        set {
            self._cellIndex = newValue
            self.commentLabel.text = "\(self._cellIndex)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // Initialization code
        self.mediaImageView = UIImageView()
        self.usernameAndCaptionLabel = UILabel()
        self.commentLabel = UILabel()
        //Super Init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        //image
        self.mediaImageView = UIImageView()
        self.mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        //username
        self.usernameAndCaptionLabel = UILabel()
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
        container.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: -8.0).active = true
        container.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: -8.0).active = true
        container.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: 0.0).active = true
        
        self.mediaImageView.topAnchor.constraintEqualToAnchor(container.topAnchor, constant: 0.0).active = true
        self.mediaImageView.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0).active = true
        self.mediaImageView.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0).active = true
        self.usernameAndCaptionLabel.topAnchor.constraintEqualToAnchor(self.mediaImageView.bottomAnchor, constant: 0.0).active = true
        self.usernameAndCaptionLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
        self.usernameAndCaptionLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
        self.commentLabel.topAnchor.constraintEqualToAnchor(self.usernameAndCaptionLabel.bottomAnchor, constant: 0.0).active = true
        self.commentLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor, constant: 0.0).active = true
        self.commentLabel.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor, constant: 0.0).active = true
        
        self.heightConstraint = self.mediaImageView.heightAnchor.constraintEqualToConstant(200.0)
//            NSLayoutConstraint(item: self.mediaImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        self.heightConstraint.active = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}




























