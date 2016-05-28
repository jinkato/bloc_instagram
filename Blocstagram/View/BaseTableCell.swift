//
//  BaseTableCell.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/27/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

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