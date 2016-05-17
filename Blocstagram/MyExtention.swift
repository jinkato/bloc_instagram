//
//  MyExtention.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/6/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

extension UIView {
    func myAddConstraint(visualFormat:String, view:UIView, viewsDictionary:[String:UIView]){
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    func myAddConstraintCenterY(view:UIView){
        addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
}

extension UIView {
    func myRemoveConstraints() {
        if let superview = self.superview {
            var list = [NSLayoutConstraint]()
            for constraint in superview.constraints {
                if constraint.firstItem as? UIView == self || constraint.secondItem as? UIView == self {
                    list.append(constraint)
                }
            }
            superview.removeConstraints(list)
        }
        self.removeConstraints(self.constraints)
    }
}

extension UIColor{
    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}