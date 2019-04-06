//
//  FirstViewController.swift
//  BMIApp
//
//  Created by cries on 2019/02/08.
//  Copyright © 2019年 cries. All rights reserved.
//

import UIKit

// 入力画面
class InputViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var BMI: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var memo: PlaceHolderTextView!
    
    var scrollView = UIScrollView()
    var isTappedTextField = false
    
    override func viewDidLoad() {
        // デリゲートをセット
        memo.delegate = self
        height.delegate = self
        weight.delegate = self
        
        super.viewDidLoad()
        // ボーダーラインを引く
        border.layer.borderWidth = 2
        // レイアウトのテストのために適当に値を設定
        BMI.text = "20.0"
        memo.placeHolder = "テスト"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }
    
    // viewがタップされた時にキーボードを隠す
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Notificationを設定
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Notificationを削除
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    // キーボードが現れた時に画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {
        if isTappedTextField == false {
            let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!, animations: { () in
                let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
                self.view.transform = transform
            })
        }
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        if isTappedTextField == false {
            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
            UIView.animate(withDuration: duration!, animations: { () in
                self.view.transform = CGAffineTransform.identity
            })
        }
        isTappedTextField = false
    }
    
    // Returnキーを押したときにキーボードを下げる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // TextFieldがタップされた時にフラグを立てる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isTappedTextField = true
    }
    
    // 計算ボタンが押された時の処理
    @IBAction func calc(_ sender: Any) {
        if let height = height.text,
            let weight = weight.text {
            // 値が未入力だったら処理しない
            if height.isEmpty || weight.isEmpty {
                return
            }
            BMI.text = String(CalculateLogic.calcBMI(height: Int(height) ?? 0, weight: Int(weight) ?? 0))
            view.endEditing(true)
        }
    }
    // 保存ボタンが押された時の処理
    @IBAction func save(_ sender: Any) {
        if let bmi = BMI.text {
            // 値が未入力だったら処理しない
            if bmi.isEmpty {
                return
            }
            let itemData = ItemData(month: "4月", day: "4日", height: "180cm", weight: "65kg", colum: "テスト")
            var itemArray: Array<ItemData> = []
            let itemArrayFromDB: Array<Any>? = AccessDataBase.findItemDataArray(key: "itemArray")
            // DBにデータがあればそのデータにappendしてDBに登録
            if let array = itemArrayFromDB as? Array<ItemData> {
                itemArray = array
            }
            itemArray.append(itemData)
            AccessDataBase.save(key: "itemArray", value: itemArray)
        }
    }
    // 削除ボタンが押された時の処理
    @IBAction func clear(_ sender: Any) {
        height.text = ""
        weight.text = ""
        BMI.text = ""
        memo.text = ""
    }
}

