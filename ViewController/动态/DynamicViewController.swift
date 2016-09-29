//
//  DynamicViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {
    
    var tableView = UITableView()
    var dataArr = NSMutableArray()
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "大众动态"
        let bar = self.navigationController?.navigationBar
        let image = UIImage.init(named: "navigationBg")?.stretchableImageWithLeftCapWidth(160, topCapHeight: 22)
        bar?.setBackgroundImage(image, forBarMetrics: .Default)
        bar?.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        tableView.header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1
            self.dataArr.removeAllObjects()
            self.loadData()
        })
        tableView.footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.page += 1
            self.loadData()
        })
        tableView.rowHeight = 200
        self.createTableView()
        self.loadData()
        
    }
    func createTableView() -> Void {
        tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib.init(nibName: "CellOne", bundle: nil), forCellReuseIdentifier: "CellOne")
        self.view.addSubview(tableView)
    }
    
    func loadData() -> Void {
        let str = "http://www.xbiao.com/bbs2/zuoyelist/loginid/0/loginkey/0/page/\(page)"
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(str, parameters: nil, progress: nil, success: { (task, download) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let dic = try! NSJSONSerialization.JSONObjectWithData(download as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let dataArr = dic["data"] as! NSArray
            for i in 0...dataArr.count-1 {
                let dic = dataArr[i] as! NSDictionary
                let model = tbModel()
                model.title = dic["title"] as! String
                model.image = dic["img"] as! String
                model.authorName = dic["author_name"] as! String
                model.brandName = dic["brand_name"] as! String
                model.tid = dic["tid"] as! String
                model.url = dic["url"] as! String
                self.dataArr.addObject(model)
            }
            self.tableView.reloadData()
            self.tableView.header.endRefreshing()
            self.tableView.footer.endRefreshing()
            }) { (task, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                print("论坛帖子信息解析错误")
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DynamicViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "论坛人气帖"
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellOne", forIndexPath: indexPath) as! CellOne
        let model = dataArr[indexPath.row] as! tbModel
        cell.introLabel.text = model.title
        cell.picView.sd_setImageWithURL(NSURL.init(string: model.image))
        cell.authorLabel.text = model.authorName
        cell.brandLabel.text = model.brandName
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //  tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let webVC = WebViewController()
        webVC.hidesBottomBarWhenPushed = true
        let model = dataArr[indexPath.row] as! tbModel
        webVC.url = model.url
        self.navigationController?.pushViewController(webVC, animated: true)        
    }
}
