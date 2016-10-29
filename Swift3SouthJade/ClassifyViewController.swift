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
    var collectionView: UICollectionView!
    var tableDataSource = [String]()
  
    var collectionDataSource = [ClassifyModule]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupRightSideTableView()
        ClassifyModule.loadTableViewData { (array) in
            self.tableDataSource = array
            self.rightSideTableView.reloadData()
        }
        
        setupCollectionView()
        loadCollectionViewData(urlString: ClassifyModule.classifyAllUrlString,
                              parameters: ["grade":"1"])
        
    }
    

    func loadCollectionViewData(urlString: String, parameters: [String:Any]) {
        
        ClassifyModule.loadCollectionViewData(urlString: urlString, parameters: parameters) { (module) in
            self.collectionDataSource.removeAll()
            self.collectionDataSource = module
            self.collectionView.reloadData()

        }
    }
    
    
    
    func setupRightSideTableView() {
        rightSideTableView.frame = CGRect(x: UIScreen.main.bounds.size.width - 100, y: 0, width: 100, height: UIScreen.main.bounds.size.height)
        
        rightSideTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rightSideTableView.delegate = self
        rightSideTableView.dataSource = self
        rightSideTableView.tableFooterView = UIView()
        view.addSubview(rightSideTableView)
    }
    
    func setupCollectionView() {
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerInset = UIEdgeInsetsMake(10, 10, 0, 10)
        layout.headerHeight = 50
        layout.minimumInteritemSpacing = 10
        layout.minimumColumnSpacing = 10
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width - 100, height: UIScreen.main.bounds.size.height-49-64), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "ClassifyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.backgroundColor = .white
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
        return tableDataSource.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.textLabel?.text = "全部"
        } else {
            cell.textLabel?.text = tableDataSource[indexPath.row-1]

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            loadCollectionViewData(urlString: ClassifyModule.classifyAllUrlString,
                                  parameters: ["grade":"1"])
        } else {
            loadCollectionViewData(urlString: ClassifyModule.collectionUrlString,
                                  parameters: ["productCategoryId":indexPath.row])
        }
        
    }
    
}

extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ClassifyCollectionViewCell

        item.itemImageView.kf.setImage(with: URL(string: collectionDataSource[indexPath.row].imageUrl))
        
        item.itemImageView.kf.setImage(with: URL(string: collectionDataSource[indexPath.row].imageUrl), placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (receiveSize, totalSize) in
            print("\(indexPath.row + 1): \(receiveSize)/\(totalSize)")

            }) { (image, error, cacheType, imageURL) in
                 print("\(indexPath.row + 1): Finished")
        }
        
        return item
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView:UICollectionReusableView!
        if kind == CollectionViewWaterfallElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            reusableView.backgroundColor = .yellow
        }
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
         let  size =  collectionDataSource[indexPath.item]
         let width = Int((collectionView.bounds.size.width - 30)/3)
         let height = Int(width) * size.imageHeight / size.imageWidth
         return CGSize(width: width, height: height)
    }
    
}

