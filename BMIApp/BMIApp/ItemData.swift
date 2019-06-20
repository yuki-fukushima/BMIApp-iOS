//
//  ItemData.swift
//  BMIApp
//
//  Created by cries on 2019/04/05.
//  Copyright © 2019年 cries. All rights reserved.
//

import Foundation

class ItemData: NSObject, NSCoding {
    // 月
    var month: String?
    // 日
    var day: String?
    // BMI
    var bmi: String?
    // 身長
    var height: String?
    // 体重
    var weight: String?
    // コメント
    var colum: String?
    
    init(month: String, day: String, bmi: String, height: String, weight: String, colum: String) {
        self.month = month
        self.day = day
        self.bmi = bmi
        self.height = height
        self.weight = weight
        self.colum = colum
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.month = aDecoder.decodeObject(forKey: "month") as? String
        self.day = aDecoder.decodeObject(forKey: "day") as? String
        self.bmi = aDecoder.decodeObject(forKey: "bmi") as? String
        self.height = aDecoder.decodeObject(forKey: "height") as? String
        self.weight = aDecoder.decodeObject(forKey: "weight") as? String
        self.colum = aDecoder.decodeObject(forKey: "colum") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        if let month = month { aCoder.encode(month, forKey: "month") }
        if let day = day { aCoder.encode(day, forKey: "day") }
        if let bmi = bmi { aCoder.encode(bmi, forKey: "bmi") }
        if let height = height { aCoder.encode(height, forKey: "height") }
        if let weight = weight { aCoder.encode(weight, forKey: "weight") }
        if let colum = colum { aCoder.encode(colum, forKey: "colum") }

    }
}
