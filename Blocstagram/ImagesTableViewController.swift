//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {

    // MARK: - Variables
    var items = RandomData.sharedInstance.mediaItems
    let lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
    let boldFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 11)!
    let usernameLabelGray: UIColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    let commentLabelGray: UIColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    let linkColor: UIColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName("setTableBackgroundColor", object: nil, queue: nil) { (notification) -> Void in
            self.setBackgroundColor()
        }
    }
    func setBackgroundColor() {
        self.tableView.backgroundColor = UIColor.grayColor();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cell for row at index")
        // Var Table
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell2", forIndexPath: indexPath) as! MediaTableViewCell
        let convertedMedia = items[indexPath.row]
        let cellWidth = cell.frame.width
        //image
        let adjustedImageHeight = findAdjustedHight( convertedMedia.image! )
        cell.mediaImageView = UIImageView(image: convertedMedia.image)
        cell.mediaImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: adjustedImageHeight)
        cell.mediaImageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        cell.mediaImageView.alpha = 0.5
        cell.mediaImageView.backgroundColor = UIColor.purpleColor()
        cell.addSubview(cell.mediaImageView)
        //Username and caption
        let thisFullName = convertedMedia.user?.fullName as! String
        let thisCaption = convertedMedia.caption
        let fullNameCount:Int = thisFullName.characters.count
        let userCaptionString: String = "\(thisFullName) \(thisCaption)"
        let usernameCaptionAttribute = NSMutableAttributedString(string: userCaptionString, attributes: [NSFontAttributeName: lightFont])
        usernameCaptionAttribute.addAttribute(NSFontAttributeName, value: boldFont, range: NSRange(location:0,length:fullNameCount))
        usernameCaptionAttribute.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: NSRange(location:0,length:fullNameCount))
        cell.usernameAndCaptionLabel.text = userCaptionString
        cell.usernameAndCaptionLabel.attributedText = usernameCaptionAttribute
        cell.usernameAndCaptionLabel.frame = CGRect(x: 0, y: adjustedImageHeight, width: cellWidth, height: 20)
        cell.usernameAndCaptionLabel.sizeToFit()
        //comment
        let usernameAndCaptionLabelHeight = cell.usernameAndCaptionLabel.frame.height
        let usernameAndImage = usernameAndCaptionLabelHeight + adjustedImageHeight
        let commentString = combineCommentText(indexPath)
        cell.commentLabel.text = commentString
        let commentAttribute = NSMutableAttributedString(string: commentString, attributes: [NSFontAttributeName: lightFont])
        cell.commentLabel.attributedText = commentAttribute
        cell.commentLabel.frame = CGRect(x: 0, y: usernameAndImage, width: cellWidth, height: 20)
        cell.commentLabel.sizeToFit()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("height for row at index path")
        let mediaItem = items[indexPath.row]
        let image = mediaItem.image!
        let sizeOfImage = image.size
        let originalImgWidth = self.view.frame.width
        let imageWidth = sizeOfImage.width
        let imageHeight = sizeOfImage.height
        let imageRatio = originalImgWidth/imageWidth
        let adjustedImageHeight = imageRatio * imageHeight
        // name and caption
        let thisFullName = mediaItem.user?.fullName as! String
        let thisCaption = mediaItem.caption
        let baseString: String = "\(thisFullName) \(thisCaption)"
        let tableWidth:CGFloat = tableView.frame.width
        let usernameHeight = heightForView(baseString, font: lightFont, width: tableWidth)
        // comments
        let commentString = combineCommentText(indexPath)
        let commentHeight = heightForView(commentString, font: lightFont, width: tableWidth)
        return CGFloat( adjustedImageHeight + usernameHeight + commentHeight)
    }
    
    // MARK: - Table Edit
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Func
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    func findAdjustedHight(theImage:UIImage) -> CGFloat{
        let sizeOfImage = theImage.size
        let originalImgWidth = self.view.frame.width
        let imageWidth = sizeOfImage.width
        let imageHeight = sizeOfImage.height
        let imageRatio = originalImgWidth/imageWidth
        let adjustedImageHeight = imageRatio * imageHeight
        return adjustedImageHeight
    }
    func combineCommentText(indexPath:NSIndexPath) -> String{
        let convertedMedia = items[indexPath.row]
        let commentCount = convertedMedia.comments.count
        var commentString = ""
        for i in 1...commentCount {
            if i == 1 {
                commentString = convertedMedia.comments[(i-1)].text as String
            }else{
                commentString = "\(convertedMedia.comments[(i-1)].text as String)\n\n\(commentString)"
            }
        }
        return commentString
    }
    
}















