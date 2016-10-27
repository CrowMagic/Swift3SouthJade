//
//  ClassifyViewController.swift
//  Swift3SouthJade
//
//  Created by 李 宇亮 on 2016/10/26.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class ClassifyViewController: UIViewController {

//    let yellowView: UIView = {
//        $0.backgroundColor = .yellow
//        return $0
//        // 确保下一行的括号内要传入 UIView()
//    }(UIView())
    

    let rightSideTableView = UITableView()
    var collectionView = UICollectionView()
    var dataSource = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupRightSideTableView()
        setupCollectionView()
        loadData()
        WWGood().getData()
    }
    
 
    func loadData() {
        let urlString = ClassifyModule.urlString
        let headers = ClassifyModule.headers
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(data: response.data!)
            for (_, subJson):(String, JSON) in json["data"] {
                
                self.dataSource.append(subJson["name"].stringValue)
            }
            
            self.rightSideTableView.reloadData()
            print(self.dataSource)
        }
        
    }
    
    func setupRightSideTableView() {
        rightSideTableView.frame =  CGRect(x: UIScreen.main.bounds.size.width - 100, y: 0, width: 100, height: UIScreen.main.bounds.size.height)
        rightSideTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rightSideTableView.delegate = self
        rightSideTableView.dataSource = self
        rightSideTableView.tableFooterView = UIView()
        view.addSubview(rightSideTableView)
    }
    
    func setupCollectionView() {
        let layout = WaterfallFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 100, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "item")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ClassifyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataSource[indexPath.row]
        return cell
        
    }
}

extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
        return item
        
    }
    
}

