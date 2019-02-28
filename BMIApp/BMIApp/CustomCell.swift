//
//  CustomCell.swift
//  BMIApp
//
//  Created by cries on 2019/02/28.
//  Copyright © 2019年 cries. All rights reserved.
//

import UIKit
import Foundation

// カスタムセルの中身を定義する
class CustomCell: UITableViewCell {
    
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var heightText: UILabel!
    @IBOutlet weak var weightText: UILabel!
    @IBOutlet weak var bmiText: UILabel!
    @IBOutlet weak var columText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
