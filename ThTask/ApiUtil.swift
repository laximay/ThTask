//
//  ApiUtil.swift
//  ThTask
//
//  Created by wenjing on 2017/12/4.
//  Copyright © 2017年 wenjing. All rights reserved.
//

import Foundation
import Alamofire


open class ApiUtil{
    
    class func shareInstance()->ApiUtil{
        let apiUtil = ApiUtil();
        return apiUtil;
}

    
    static let serverUrl = "https://cloud.ablegenius.com/a"
    //公司代碼
    static let companyCode = "taoheung"
    //公司代碼
    static let channel = "IOS"
    //首頁鏈接
    static let openUrl = "https://cloud.ablegenius.com/m/hkdx/index.html"
    
    //啟動頁Api
    static let launchApi = serverUrl + "/api/app/start"


    static func launchCache_New(_ completion: @escaping (String)->()) -> Void {

        Alamofire.request(ApiUtil.launchApi, method: .post, parameters: ["company": ApiUtil.companyCode]).responseJSON { response in
            print(response.result)
                        if response.result.isSuccess {
                                guard let json = response.result.value as? NSDictionary else{
                                    return
                                }
                            
                                let datas = DwStartRootClass(fromDictionary: json).data!
                                if let ads = datas.ads{
                                    // let idx = Int(arc4random()) % ads.count
                                    let launchUrl = ads.image
                                    completion(launchUrl!)
                
                                }
                            }
        }
        
      
    }
}
