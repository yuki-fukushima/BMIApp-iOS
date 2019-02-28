//
//  CalculateLogic.swift
//  BMIApp
//
//  Created by cries on 2019/02/12.
//  Copyright © 2019年 cries. All rights reserved.
//

import UIKit

class CalculateLogic {
    // 身長と体重を受け取ってBMIの値を返す
    static func calcBMI(height: Int, weight: Int) -> Double {
        let powerdheight = pow(Double(height) / 100, 2)
        let BMI = Double(weight) / powerdheight
        return floor(BMI * 100) / 100
        
    }
}
