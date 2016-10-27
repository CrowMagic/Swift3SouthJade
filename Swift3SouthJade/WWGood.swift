//
//  WWGood.swift
//  Swift3SouthJade
//
//  Created by 李 宇亮 on 2016/10/27.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class WWGood: NSObject {
    var width = 0
    var height = 0
    var url = ""
    var name = ""
    
//    //字典转模型
//    static func goodWithDict(dic:NSDictionary ) -> WWGood {
//        let good =  WWGood.init()
//        good.setValuesForKeys(dic as! [String : AnyObject])
//        return good
//    }
//    
//    // 根据索引返回商品数组
//    static func goodsWithIndex(index:Int8) -> NSArray {
//        let fileName = "\(index % 3 + 1).plist"
//        let path = Bundle.main.path(forResource: fileName, ofType: nil)
//        let goodsAry = NSArray.init(contentsOfFile: path!)
//        let goodsArray = goodsAry?.map{self.goodWithDict(dic: $0 as! NSDictionary)}
//        return goodsArray! as NSArray
//    }
    
    func getData() {
        let urlString = ClassifyModule.collectionUrlString
        let headers = ClassifyModule.headers
        Alamofire.request(urlString, method: .post, parameters: ["productCategoryId": "1"], encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(data: response.data!)
            for (_, subJson):(String, JSON) in json["data"] {
                let goodsModel = WWGood()
                goodsModel.width = subJson["image"]["width"].intValue
                goodsModel.height = subJson["image"]["height"].intValue
                goodsModel.url = subJson["image"]["url"].stringValue
                goodsModel.name = subJson["name"].stringValue
                
                print(goodsModel.name)

                
            }
            
          
        }
        

    }
    
    
}
