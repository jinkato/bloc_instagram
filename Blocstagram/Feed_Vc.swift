//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController, FeedCellDelegate {

    // MARK: - Variables
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
        self.tableView.registerClass(FeedCell.self, forCellReuseIdentifier: cellId)
    }
    
    // MARK: - Table view ----------------------------------------------------------------------------

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let count = DataSource.sharedInstance.feeds.count
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! FeedCell
        cell.feed = DataSource.sharedInstance.feeds[indexPath.row]
        cell.commentArray = DataSource.sharedInstance.feeds[indexPath.row].comments
        // Cell Delegate
        if cell.cellDelegate == nil {
            cell.cellDelegate = self
        }
        return cell
    }
    
    // MARK: - Delegate Func -------------------------------------------
    
    func imageTapped(cell: FeedCell) {
        let nextVc:FullImage_vc = FullImage_vc()
        nextVc.modalPresentationStyle = .OverCurrentContext
        presentViewController(nextVc, animated: true, completion: nil)
    }
    func imageLongPressed() {
//        Utils.presentShareView(self as UIViewController)
    }
    
    // MARK: - Table Func -------------------------------------------
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tableWidth:CGFloat = tableView.frame.width
        // Name and caption
        let fullName = DataSource.sharedInstance.feeds[indexPath.row].user?.fullName as! String
        let caption = DataSource.sharedInstance.feeds[indexPath.row].caption as String
        let userCaptionString = "\(fullName) \(caption)"
        let nameSize = CGSizeMake(tableWidth, 1000)
        let nameRect = NSString(string: userCaptionString).boundingRectWithSize(nameSize, options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(11)], context: nil)
        // Comment
        let commentArray = DataSource.sharedInstance.feeds[indexPath.row].comments
        let commentText = Utils.concatenateCommentArray(commentArray)
        let commentSize = CGSizeMake(tableWidth, 1000)
        let commentRect = NSString(string: commentText).boundingRectWithSize(commentSize, options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(11)], context: nil)
        return CGFloat( tableWidth + nameRect.height + commentRect.height)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
            //RandomData.sharedInstance.requestOldItems()
        }
    }
    
    // MARK: - Func ----------------------------------------------------------------------------
    
    func refresh(sender:AnyObject){
        self.myRefreshControl.endRefreshing()
    }
    
    func reloadTable(){
        self.tableView.reloadData()
    }
    
    func share(){
        let vc = UIActivityViewController(activityItems: ["share text"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}







