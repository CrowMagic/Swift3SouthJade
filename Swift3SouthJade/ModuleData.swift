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




private var ipString = "http://192.168.2.22:8090"
private let headers = HTTPHeaders(dictionaryLiteral: ("appid", "RbpQ8flsM61Wh6QDB1HCIy2rYMfba626"), ("appsecret", "capitalofsouthjadeinchina"))

class ClassifyModule {
    
    
    
    static func loadTableViewData(complete:@escaping ([String]) -> ()) {
        
        let urlString = ipString.appending("/wap/productCategory/list")
        var array = [String]()
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(data: response.data!)
            for (_, subJson):(String, JSON) in json["data"] {
                
                array.append(subJson["name"].stringValue)
            }
            complete(array)
        }
    }

    
    
    /// classify collection view source detail
    var imageId = 0
    var imageUrl = ""
    var imageWidth = 0
    var imageHeight = 0
    static let classifyAllUrlString = "http://192.168.2.22:8090/wap/productCategory/allList"
    static let collectionUrlString = "http://192.168.2.22:8090/wap/productCategory/childList"
    
    static func loadCollectionViewData(urlString: String, parameters:[String:Any], complete: @escaping ([ClassifyModule]) -> ()) {
        let url = urlString
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(data: response.data!)
            
            var array = [ClassifyModule]()
            for (_, subJson):(String, JSON) in json["data"] {
                let module = ClassifyModule()
                module.imageId = subJson["id"].intValue
                module.imageUrl = subJson["image"]["url"].stringValue
                module.imageWidth = subJson["image"]["width"].intValue
                module.imageHeight = subJson["image"]["height"].intValue
                
                array.append(module)
                
            }
            complete(array)
        }
        
    }
}

    
class SouthJadeModule {
    
    
          var jadeId = 0
            var name = ""
           var price = 0
    var imageUrl     = ""
    var imageWidth   = 0
    var imageHeight  = 0
    var signetUrl    = ""
    var signetWidth  = 0
    var signetHeight = 0
    
    
    
    
    static func loadCollectionViewData(complete: @escaping ([SouthJadeModule]) -> ()) {
        let url = ipString.appending("/wap/product/productCategoryList")
        
        Alamofire.request(url, method: .post, parameters: ["orderType":"news", "productCategoryId":"1", "productCategoryIds":[""]], encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(data: response.data!)
            var array = [SouthJadeModule]()
            
            for (key, subJson):(String, JSON) in json["data"] {
                print(key, subJson)
                let module = SouthJadeModule()
                module.jadeId = subJson["id"].intValue
                module.name = subJson["name"].stringValue
                module.price = subJson["price"].intValue
                module.imageUrl = subJson["image"]["url"].stringValue
                module.imageWidth = subJson["image"]["width"].intValue
                module.imageHeight = subJson["image"]["height"].intValue
                module.signetUrl = subJson["signet"]["url"].stringValue
                module.signetWidth = subJson["signet"]["width"].intValue
                module.signetHeight = subJson["signet"]["height"].intValue
                array.append(module)
            }
            complete(array)
        }
     }
    
}


