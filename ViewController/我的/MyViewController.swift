//
//  MyViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    
    @IBOutlet weak var PostTextField: UITextField!
    @IBOutlet weak var PassWordField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var ResgisterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的信息"
        let bar = self.navigationController?.navigationBar
        let image = UIImage.init(named: "navigationBg")?.stretchableImageWithLeftCapWidth(160, topCapHeight: 22)
        bar?.setBackgroundImage(image, forBarMetrics: .Default)
        bar?.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.view.backgroundColor = UIColor.lightGrayColor()
        
    }
    
    @IBAction func LoginClick(sender: AnyObject) {
        
        //http://www.xbiao.com/app/login/t/android/   username=312567604%40qq.com&PHPSESSID=&password=123zhang6qq0.
        //登录接口
        let urlStr = "http://www.xbiao.com/app/login/t/android/"
        
        //使用afn进行post请求时，参数以字典的形式存在
        let bodyDid = ["username": PostTextField.text!, "password": PassWordField.text!,"PHPSESSID":""]
        
        //afn进行网络请求时需要使用的对象
        let manager = AFHTTPSessionManager()
        
        //取消afn的自动json解析
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        //启动post请求
        manager.POST(urlStr, parameters: bodyDid, progress: nil, success: { (task, downloadData) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(downloadData as! NSData, options: .AllowFragments) as! [[String:AnyObject]]
            print(dic)
            let code = dic[0]["code"]! as! NSNumber
            let message = dic[0]["message"]! as! String
            if code == 0 {
                
                //用户身份标记
                
                //将身份标记保存起来
                
                
                //如果登录成功，直接跳转到HomeVC
             //   self.performSegueWithIdentifier("pushHome", sender: nil)
                
                print("登陆成功,准备跳转页面啦")
                
                return
            }
            
            //警告框
            let ac = UIAlertController.init(title: "\(code)", message: message, preferredStyle: .Alert)
            let action = UIAlertAction.init(title: "好", style: .Default, handler: nil)
            ac.addAction(action)
            self.presentViewController(ac, animated: true, completion: nil)
            
        }) { (task, error) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            print("登录时，网络发生了错误")
        }
    }
    
    @IBAction func RegisterClick(sender: AnyObject) {
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
