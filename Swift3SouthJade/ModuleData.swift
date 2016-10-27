//
//  ModuleData.swift
//  Swift3SouthJade
//
//  Created by 李 宇亮 on 2016/10/26.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ClassifyModule {
    
    
    static let urlString = "http://192.168.2.22:8090/wap/productCategory/list"
    static let headers = HTTPHeaders(dictionaryLiteral: ("appid", "RbpQ8flsM61Wh6QDB1HCIy2rYMfba626"), ("appsecret", "capitalofsouthjadeinchina"))
    
    static let collectionUrlString = "http://192.168.2.22:8090/wap/productCategory/childList"
    
    

    
    
}
struct NetWorkConfig {
   
}

