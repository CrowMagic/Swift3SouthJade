//
//  SouthJadeCollectionViewCell.swift
//  Swift3SouthJade
//
//  Created by 李 宇亮 on 2016/10/28.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import UIKit

class SouthJadeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!

    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellSignetImageView: UIImageView!
    
    @IBOutlet weak var cellPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
