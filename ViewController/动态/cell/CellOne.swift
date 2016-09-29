//
//  CellOne.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class CellOne: UITableViewCell {

    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        authorLabel.textColor = UIColor.lightGrayColor()
        brandLabel.textColor = UIColor.brownColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
