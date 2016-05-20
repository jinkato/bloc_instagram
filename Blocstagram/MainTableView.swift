//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController {

    // MARK: - Variables
    var mediaList:[Media] = []
    
    let lightFont: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 11)!
    let boldFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 11)!
    let linkColor: UIColor = UIColor(red: 0.345, green: 0.314, blue: 0.427, alpha: 1)
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
        self.tableView.registerClass(MediaCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func reloadTable(){
        self.mediaList = RandomData.sharedInstance.mediaItems
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let count = self.mediaList.count
        return count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! MediaCell
        // Username and caption
        let fullName = self.mediaList[indexPath.row].user?.fullName as! String
        let caption = self.mediaList[indexPath.row].caption as String
        let fullNameCount:Int = fullName.characters.count
        let userCaptionString = "\(fullName) \(caption)"
        let usernameCaptionAttribute = NSMutableAttributedString(string: userCaptionString, attributes: [NSFontAttributeName: lightFont])
        usernameCaptionAttribute.addAttribute(NSFontAttributeName, value: boldFont, range: NSRange(location:0,length:fullNameCount))
        usernameCaptionAttribute.addAttribute(NSForegroundColorAttributeName, value: linkColor, range: NSRange(location:0,length:fullNameCount))
        usernameCaptionAttribute.addAttribute(NSKernAttributeName, value: 2, range: NSRange(location:0,length:fullNameCount))
        cell.usernameAndCaptionLabel.text = userCaptionString
        cell.usernameAndCaptionLabel.attributedText = usernameCaptionAttribute
        // Image
        let cellImage = self.mediaList[indexPath.row].mediaURL as String
        Utils.asyncLoadImage(cellImage, imageView: cell.mediaImageView)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mediaItem = self.mediaList[indexPath.row] 
        // Image
        let tableWidth:CGFloat = tableView.frame.width
        // Name and caption
        let fullName = mediaItem.user?.fullName as! String
        let caption = mediaItem.caption as String
        let userCaptionString = "\(fullName) \(caption)"
        let usernameHeight = Utils.heightForView(userCaptionString, font: lightFont, width: tableWidth)
        return CGFloat( tableWidth + usernameHeight)
    }
    
    // MARK: - Table view scroll
    
        override func scrollViewDidScroll(scrollView: UIScrollView) {
            //If we reach the end of the table.
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
                //RandomData.sharedInstance.requestOldItemsWithCompletionHandler()
                self.tableView.reloadData()
            }
        }
    
    // MARK: - Table Edit
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.mediaList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    
    
    // MARK: - Func
    
    func refresh(sender:AnyObject){
        RandomData.sharedInstance.requestNewItemsWithCompletionHandler { (_) -> Void in
            
            
            
            self.tableView.reloadData()
        }
        //self.tableView.reloadData()
        self.myRefreshControl.endRefreshing()
    }
}















