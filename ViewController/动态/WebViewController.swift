//
//  WebViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

//    var str:String = ""
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "人气帖子"
        let webView = UIWebView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64))
        let request = NSMutableURLRequest.init(URL: NSURL.init(string: url)!)
        webView.loadRequest(request)
//        webView.delegate = self
        self.view.addSubview(webView)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
//extension WebViewController:UIWebViewDelegate {
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        
//        
//        return true
//    }
//}