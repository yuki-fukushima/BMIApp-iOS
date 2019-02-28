//
//  SecondViewController.swift
//  BMIApp
//
//  Created by cries on 2019/02/08.
//  Copyright © 2019年 cries. All rights reserved.
//

import UIKit

// 履歴画面
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
    }
    // セルの中身を定義する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // レイアウトのテストのために仮のデータを表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
            cell.bmiText.text = "BMI: 20.3"
            cell.dayText.text = "20日"
            cell.heightText.text = "身長:172cm"
            cell.weightText.text = "体重:60kg"
        if indexPath.row == 2 {
            cell.columText.text = "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト"
        } else {
            cell.columText.text = ""
        }
        return cell
    }
    
    // 表示するセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // レイアウトのテストのために適当に値を設定
        if section == 0 {
            return 5
        } else {
            return 3
        }    }
    
    // 表示するセクションのタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // レイアウトのテストのために適当に値を設定
        if section == 0 {
            return "1月"
        } else {
            return "2月"
        }
    }
    
    // 表示するセクションの数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        // レイアウトのテストのために適当に値を設定
        return 2
    }
}

