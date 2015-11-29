//
//  ImagesTableViewController.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {

    var images : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...10 {
            let imageName : String = "\(i).jpg";
            images.append(imageName)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.images.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as UITableViewCell
        let imageViewObject :UIImageView = UIImageView()
        let w = cell.frame.width
        let h = cell.frame.height
        
        imageViewObject.frame = CGRect(x: 0, y: 0, width: w, height: h)
        //imageViewObject.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        //imageViewObject.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        imageViewObject.image = UIImage(named:images[indexPath.row])
        cell.addSubview(imageViewObject)

        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let image = UIImage(named: images[indexPath.row])
        let sizeOfImage = image?.size
        let outerViewWidth = self.view.frame.width
        let imageWidth = sizeOfImage!.width
        let imageHeight = sizeOfImage!.height
        return CGFloat((outerViewWidth/imageWidth) * imageHeight)
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            print("delete")
            images.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}















