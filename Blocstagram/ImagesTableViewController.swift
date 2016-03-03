//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {

    var items = RandomData.sharedInstance.mediaItems
    
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
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell2", forIndexPath: indexPath) as! MediaTableViewCell
        let convertedMedia = items[indexPath.row] 
        cell.usernameAndCaptionLabel.text = (convertedMedia.user?.fullName as! String)
        cell.commentLabel.text = convertedMedia.comments[0].text as String
        
        let imageName = String(indexPath.row + 1) + ".jpg"
        let image = UIImage(named: imageName)
        cell.mediaImageView = UIImageView(image: image)
        let w = cell.frame.width
        let h = cell.frame.height - 100
        cell.mediaImageView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        cell.mediaImageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        cell.addSubview(cell.mediaImageView)
        cell.usernameAndCaptionLabel.frame = CGRect(x: 0, y: h, width: 100, height: 50)
        cell.commentLabel.frame = CGRect(x: 0, y: h, width: 100, height: 100)

        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let mediaItem = items[indexPath.row]
        let image = mediaItem.image!
        let sizeOfImage = image.size
        let outerViewWidth = self.view.frame.width
        let imageWidth = sizeOfImage.width
        let imageHeight = sizeOfImage.height
        return CGFloat(((outerViewWidth/imageWidth) * imageHeight ) + 100)
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

}















