//
//  ViewController.swift
//  L11HelloIOS
//
//  Created by zhanghl on 16/1/7.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet var vw:UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var url:String = "http://www.baidu.com"
//        if let myVw=vw{
        
            let url = NSURL(string: "http://www.iteye.com/")!
            let request = NSURLRequest(URL: url)
            vw.loadRequest(request)
        
            self.view.backgroundColor = UIColor.blackColor()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

