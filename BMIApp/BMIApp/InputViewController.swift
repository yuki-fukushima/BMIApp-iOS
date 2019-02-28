//
//  FirstViewController.swift
//  BMIApp
//
//  Created by cries on 2019/02/08.
//  Copyright © 2019年 cries. All rights reserved.
//

import UIKit

// 入力画面
class InputViewController: UIViewController {

    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var BMI: UITextView!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var border: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ボーダーラインを引く
        border.layer.borderWidth = 2
        // レイアウトのテストのために適当に値を設定
        BMI.text = "20.0"
    }
    
    // 計算ボタンが押された時の処理
    @IBAction func calc(_ sender: Any) {
        if let height = self.height.text,
            let weight = self.weight.text {
            self.BMI.text = String(CalculateLogic.calcBMI(height: Int(height) ?? 0, weight: Int(weight) ?? 0))
            self.height.endEditing(true)
            self.weight.endEditing(true)

        }
    }
}

