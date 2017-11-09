//
//  ViewController.swift
//  ThTask
//
//  Created by wenjing on 2017/11/9.
//  Copyright © 2017年 wenjing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    @IBAction func btnTouchUp(_ sender: Any) {
        let alias = textField.text
        //注册别名
        JPUSHService.setAlias(alias,
                              callbackSelector: #selector(tagsAliasCallBack(resCode:tags:alias:)),
                              object: self)
    }
    
    @objc func tagsAliasCallBack(resCode:CInt, tags:NSSet, alias:NSString) {
        textView.text = "响应结果：\(resCode)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

