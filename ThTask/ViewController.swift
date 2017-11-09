//
//  ViewController.swift
//  ThTask
//
//  Created by wenjing on 2017/11/9.
//  Copyright © 2017年 wenjing. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController , WKUIDelegate, WKNavigationDelegate {
    
    lazy private var webview: WKWebView = {
        self.webview = WKWebView.init(frame: self.view.bounds)
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        return self.webview
    }()
    
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: UIScreen.main.bounds.width, height: 3))
        self.progressView.tintColor = UIColor.green      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(webview)
        view.addSubview(progressView)
        webview.autoresizingMask = [.flexibleHeight]
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        let url = "http://task.dongwangtech.com:8081/TaskManage/appPage/login.jsp"
        webview.load(URLRequest.init(url: URL.init(string: url)!))
        
      
        
    
//        JPUSHService.setAlias(alias,
//                              callbackSelector: #selector(tagsAliasCallBack(resCode:tags:alias:)),
//                              object: self)
    
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //print("开始加载")
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //print("开始获取网页内容")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //print("加载完成")
        //调用h5的localStorage.getItem
        webview.evaluateJavaScript("localStorage.getItem('loginCode');") { (any, err) in
           
            
            if let result: String  = any as? String {
            if  result.count > 0 {
                
             
                let defaults = UserDefaults.standard
                guard (defaults.string(forKey: "alias") != nil) else {
                   return  defaults.set("alias" ,forKey: "alias")
                }
                
                let alias_l: String = defaults.string(forKey: "alias")!
                print("返回值:\(result.lowercased() ) 别名\(alias_l)")
                if result.lowercased() != alias_l{
                         print("返回值_in:\(result.lowercased() ) 别名\(alias_l)")
                        JPUSHService.setAlias(result.lowercased(),
                                              callbackSelector: #selector(self.tagsAliasCallBack(resCode:tags:alias:)),
                                              object: self)
                }
                
            }else{
                let defaults = UserDefaults.standard
                defaults.set("alias" ,forKey: "alias")
            }
        }
        }
        
    }
    
    @objc func tagsAliasCallBack(resCode:CInt, tags:NSSet, alias:NSString) {
        print("响应结果：\(resCode)")//6002
        if(resCode - 6002 == 0){
            let defaults = UserDefaults.standard
            defaults.set(alias ,forKey: "alias")
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //print("加载失败")
//        let menu = UIAlertController(title: nil, message: "加载失败", preferredStyle: .alert)
//        
//        let optionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        menu.addAction(optionOK)
//        
//        self.present(menu, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: "estimatedProgress")
        webview.uiDelegate = nil
        webview.navigationDelegate = nil
    }


}

