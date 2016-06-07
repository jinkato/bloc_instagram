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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        let image = UIImage(named: "book.png")
        imageView = UIImageView(image: image)
        scrollview = UIScrollView(frame: view.bounds)
        //scrollview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //scrollview.backgroundColor = UIColor.blueColor()
        scrollview.contentSize = imageView.bounds.size
        scrollview.addSubview(imageView)
        view.addSubview(scrollview)
        //scrollview.contentOffset = CGPoint(x: 100, y: 100)
        scrollview.delegate = self
        setZoomParametersForSize(scrollview.bounds.size)
        scrollview.zoomScale = scrollview.minimumZoomScale
        recenterImage()
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