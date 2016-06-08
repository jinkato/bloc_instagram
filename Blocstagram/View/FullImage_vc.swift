//
//  FullScreenImage.swift
//  Blocstagram
//
//  Created by Jin Kato on 6/6/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

class FullImage_vc:UIViewController, UIScrollViewDelegate {
    
    var imageView = UIImageView()
    var scrollview = UIScrollView()
    var currentScale:CGFloat?
    var shareButton:UIButton = {
       let button = UIButton()
        button.setTitle("Share", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.blueColor()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        // ScrollView
        let image = DataSource.sharedInstance.selectedFeed?.image
        imageView = UIImageView(image: image)
        scrollview = UIScrollView(frame: view.bounds)
        scrollview.contentSize = imageView.bounds.size
        scrollview.addSubview(imageView)
        view.addSubview(scrollview)
        scrollview.delegate = self
        setZoomParametersForSize(scrollview.bounds.size)
        scrollview.zoomScale = scrollview.minimumZoomScale
        recenterImage()
        // UI
        self.view.addSubview(shareButton)
        self.view.myAddConstraint("V:|-20-[shareButton(50)]", view: shareButton, viewsDictionary: ["shareButton":shareButton])
        self.view.myAddConstraint("H:[shareButton(100)]|", view: shareButton, viewsDictionary: ["shareButton":shareButton])
        shareButton.addTarget(self, action: "sharePressed", forControlEvents: UIControlEvents.TouchUpInside)
        // Guestreu
        imageView.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTap:")
        singleTap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(singleTap)
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped:")
        doubleTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTap)
        singleTap.requireGestureRecognizerToFail(doubleTap)
    }
    func sharePressed(){
        Utils.presentShareView(self as UIViewController)
    }
    func singleTap(gestureRecognizer: UIGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    func doubleTapped(gestureRecognizer: UIGestureRecognizer) {
        if scrollview.zoomScale == scrollview.minimumZoomScale {
            let scrollViewSize = scrollview.bounds.size
            let locationPoint = gestureRecognizer.locationInView(self.imageView)
            let width = scrollViewSize.width / self.scrollview.maximumZoomScale;
            let height = scrollViewSize.height / self.scrollview.maximumZoomScale;
            let x = locationPoint.x - (width / 2);
            let y = locationPoint.y - (height / 2);
            let rect = CGRectMake(x, y, width, height)
            scrollview.zoomToRect(rect, animated: true)
        }else{
            let scrollViewSize = scrollview.bounds.size
            let locationPoint = gestureRecognizer.locationInView(self.imageView)
            let width = scrollViewSize.width / self.scrollview.minimumZoomScale;
            let height = scrollViewSize.height / self.scrollview.minimumZoomScale;
            let x = locationPoint.x - (width / 2);
            let y = locationPoint.y - (height / 2);
            let rect = CGRectMake(x, y, width, height)
            scrollview.zoomToRect(rect, animated: true)
        }
    }
    
    func setZoomParametersForSize(scrollViewSize: CGSize){
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        scrollview.minimumZoomScale = minScale
        scrollview.maximumZoomScale = 3.0
    }
    
    // Scroll and Zoom
    
    func recenterImage(){
        let scrollViewSize = scrollview.bounds.size
        let imageSize = imageView.frame.size
        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        scrollview.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        currentScale = scrollView.zoomScale
        recenterImage()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}