//
//  InstagramLogin.swift
//  Blocstagram
//
//  Created by Jin Kato on 4/18/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

class InstagramLogin: UIViewController, UIWebViewDelegate {
    let LoginViewControllerDidGetAccessTokenNotification = "LoginViewControllerDidGetAccessTokenNotification"
    let webView:UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Nav item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backAction")
        
        webView.frame = self.view.bounds
        webView.delegate = self;
        self.view.addSubview(webView)
        self.title = NSLocalizedString("Login", comment: "Login")
    
        let clientID = RandomData.sharedInstance.instagramClientID()
        let redirectString = redirectURI()
        let urlString = "https://instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectString)&response_type=token"
        let urlStringEncoding = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url : NSURL? = NSURL(string: urlStringEncoding)
        if(url != nil){
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        }
    }
    func backAction(){
        if webView.canGoBack {
            webView.goBack()
        }
    }
    func redirectURI() -> String{
        return "http://bloc.io"
    }
    deinit{
        webView.delegate = nil
        clearInstagramCookies()
    }
    func clearInstagramCookies(){
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlString = request.URL?.absoluteString
        if urlString!.hasPrefix(redirectURI()){
            let rangeOfAccessTokenParameter = urlString!.rangeOfString( redirectURI() )
            var tokenText = urlString
            tokenText?.removeRange(rangeOfAccessTokenParameter!)
            let tokenUrlText = "/#access_token="
            let rangeOfTokenUrlText = tokenText?.rangeOfString( tokenUrlText )
            tokenText?.removeRange( rangeOfTokenUrlText! )
            NSNotificationCenter.defaultCenter().postNotificationName("accessTokenGetter", object: tokenText!)
        }
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


























