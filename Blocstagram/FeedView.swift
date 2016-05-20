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
    //var items = RandomData.sharedInstance.mediaItems
    var mediaList:[Media] = []
    
    let lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
    let boldFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 11)!
    let linkColor: UIColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
    let container = UILayoutGuide()
    var myRefreshControl: UIRefreshControl!
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable", name: "com.reloadtable", object: nil)
        self.myRefreshControl = UIRefreshControl()
        self.myRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.myRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.myRefreshControl)
        self.tableView.backgroundColor = UIColor.grayColor()
        self.tableView.registerClass(MediaCell.self, forCellReuseIdentifier: cellId)

        
    }
    
    func reloadTable(){
        print("reload called")
        self.mediaList = RandomData.sharedInstance.mediaItems
        self.tableView.reloadData()
    }
//    func refresh(sender:AnyObject){
//        RandomData.sharedInstance.requestNewItemsWithCompletionHandler { (_) -> Void in
//            self.tableView.reloadData()
//        }
//        //self.tableView.reloadData()
//        self.myRefreshControl.endRefreshing()
//    }
    
    // MARK: - Table view scroll
    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        //If we reach the end of the table.
//        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
//            //RandomData.sharedInstance.requestOldItemsWithCompletionHandler()
//            self.tableView.reloadData()
//        }
//    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let count = self.mediaList.count
        print("row = \(count)")

        return count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! MediaCell
        cell.usernameAndCaptionLabel.text = self.mediaList[indexPath.row].idNumber as String
        cell.commentLabel.text = self.mediaList[indexPath.row].idNumber as String
        // image ------------------------------------------------------------------------------
//        cell.mediaImageView.image = convertedMedia.image
//        let originalHeight = cell.mediaImageView.image?.size.height
//        let originalWidth = cell.mediaImageView.image?.size.width
//        if(originalHeight > originalWidth){
//            cell.widthConstraint.constant = findRadioWidthBigger(convertedMedia.image!) * 100
//            cell.heightConstraint.constant = 100
//        }else{
//            cell.widthConstraint.constant = 100
//            cell.heightConstraint.constant = findRadioHeightBigger(convertedMedia.image!) * 100
//        }
        // Username and caption ------------------------------------------------------------------------------
//        let thisFullName = convertedMedia.user?.fullName as! String
//        let thisCaption = convertedMedia.caption
//        let fullNameCount:Int = thisFullName.characters.count
//        let userCaptionString: String = "\(thisFullName) \(thisCaption)"
//        let usernameCaptionAttribute = NSMutableAttributedString(string: userCaptionString, attributes: [NSFontAttributeName: lightFont])
//        usernameCaptionAttribute.addAttribute(NSFontAttributeName, value: boldFont, range: NSRange(location:0,length:fullNameCount))
//        usernameCaptionAttribute.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: NSRange(location:0,length:fullNameCount))
//        usernameCaptionAttribute.addAttribute(NSKernAttributeName, value: 2, range: NSRange(location:0,length:fullNameCount))
//        cell.usernameAndCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        cell.usernameAndCaptionLabel.text = userCaptionString
//        cell.usernameAndCaptionLabel.attributedText = usernameCaptionAttribute
//        cell.usernameAndCaptionLabel.frame.size.height = 20
//        cell.usernameAndCaptionLabel.frame.size.width = cellWidth
        // comment ------------------------------------------------------------------------------
//        let commentCount = convertedMedia.comments.count
//        var commentString = ""
//        for i in 1...commentCount {
//            let username = convertedMedia.comments[(i-1)].from!.fullName as String
//            if i == 1 {
//                commentString = "\(username) \(convertedMedia.comments[(i-1)].text as String)"
//            }else{
//                commentString = "\(commentString)\n\n\(username) \(convertedMedia.comments[(i-1)].text as String)"
//            }
//        }
//        cell.commentLabel.text = commentString
//        cell.commentLabel.translatesAutoresizingMaskIntoConstraints = false
//        let commentAttribute = NSMutableAttributedString(string: commentString, attributes: [NSFontAttributeName: lightFont])
//        var characterCount = 0
//        for i in 1...commentCount {
//            let username = convertedMedia.comments[(i-1)].from!.fullName as String
//            let comment = convertedMedia.comments[(i-1)].text as String
//            let usernameCount = username.characters.count
//            let commentCount = comment.characters.count
//            commentAttribute.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: NSRange(location:characterCount,length:usernameCount))
//            commentAttribute.addAttribute(NSFontAttributeName, value: boldFont, range: NSRange(location:characterCount,length:usernameCount))
//            characterCount += (usernameCount + commentCount + 3)
//        }
//        cell.commentLabel.attributedText = commentAttribute
//        cell.commentLabel.frame.size.height = 20
//        cell.commentLabel.frame.size.width = cellWidth
//        cell.commentLabel.sizeToFit()
        // return ------------------------------------------------------------------------------
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let mediaItem = items[indexPath.row] as! Media
//        let image = mediaItem.image!
//        let sizeOfImage = image.size
//        var finalImageHeight:CGFloat = 100
//        let originalHeight = sizeOfImage.height
//        let originalWidth = sizeOfImage.width
//        if(originalWidth > originalHeight){
//            finalImageHeight = findRadioHeightBigger(mediaItem.image!) * 100
//        }
//        // name and caption
//        let thisFullName = mediaItem.user?.fullName as! String
//        let thisCaption = mediaItem.caption
//        let baseString: String = "\(thisFullName) \(thisCaption)"
//        let tableWidth:CGFloat = tableView.frame.width
//        let usernameHeight = heightForView(baseString, font: lightFont, width: tableWidth)
//        // comments
//        let commentString = combineCommentText(indexPath)
//        let commentHeight = heightForView(commentString, font: lightFont, width: tableWidth)
//        return CGFloat( finalImageHeight + usernameHeight + commentHeight)
        return 300
    }
    
    // MARK: - Table Edit
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            items.removeObjectAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }
    
    // MARK: - Func
    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "mediaItems" {
//            print("observed")
//        }
//        print("count")
//    }
    
    

//    func combineCommentText(indexPath:NSIndexPath) -> String{
//        let convertedMedia = items[indexPath.row]
//        let commentCount = convertedMedia.comments.count
//        var commentString = ""
//        for i in 1...commentCount {
//            let username = convertedMedia.comments[(i-1)].from!.fullName
//            if i == 1 {
//                commentString = "\(username)  \(convertedMedia.comments[(i-1)].text as String)"
//            }else{
//                commentString = "\(username)  \(convertedMedia.comments[(i-1)].text as String)\n\n\(commentString)"
//            }
//        }
//        return commentString
//    }
    
}















