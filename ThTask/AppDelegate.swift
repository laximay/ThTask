//
//  AppDelegate.swift
//  ThTask
//
//  Created by wenjing on 2017/11/9.
//  Copyright © 2017年 wenjing. All rights reserved.
//

import UIKit
import ZLaunchAdVC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let homeVC = ViewController()
        if launchOptions != nil {
            /// 通过推送等方式启动
            window?.rootViewController = homeVC
        } else {
            /// 加载广告

            let adVC = ZLaunchAdVC(waitTime: 4,rootVC: homeVC)
            ApiUtil.launchCache_New { imgUrl in
               
                adVC.setImage(imgUrl, duration: 3, options: .readCache, action:nil)
            }

            window?.rootViewController = adVC
        }
        window?.makeKeyAndVisible()
        
       
        return true
    }


}

