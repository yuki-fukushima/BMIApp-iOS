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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    // セルの中身を定義する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let itemArray = AccessDataBase.findItemDataArray(key: "itemArray") as? [ItemData] ?? []
        let parsedTodoDict = parseDateTimeTodoList(itemArray: itemArray)
        let sectionArray = createSectionArray(itemArray: itemArray)
        
        let thisSectionTodoList = parsedTodoDict[sectionArray[indexPath.section]]
        let item = thisSectionTodoList?[indexPath.row]
        let day = item?.day
        let bmiText = item?.bmi ?? ""
        let heightText = item?.height ?? ""
        let weightText = item?.weight ?? ""
        let columText = item?.colum ?? ""

        cell.bmiText.text = "BMI:" + bmiText
        cell.dayText.text = day
        cell.heightText.text = "身長:" + heightText + "cm"
        cell.weightText.text = "体重:" + weightText + "kg"
        if !columText.isEmpty {
            cell.columText.text = columText
        }
        return cell
    }
    
    // 表示するセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemArray = AccessDataBase.findItemDataArray(key: "itemArray") as? [ItemData] ?? []
        let parsedTodoDict = parseDateTimeTodoList(itemArray: itemArray)
        let sectionArray = createSectionArray(itemArray: itemArray)
        let thisSectionTodoList = parsedTodoDict[sectionArray[section]]
        //戻り値の設定(表示するcell数)
        return thisSectionTodoList?.count ?? 0
    }
    
    // 表示するセクションのタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let itemArray = AccessDataBase.findItemDataArray(key: "itemArray") as? [ItemData] ?? []
        let sectionArray = createSectionArray(itemArray: itemArray)
        return sectionArray[section]
    }
    
    // 表示するセクションの数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        let itemArray = AccessDataBase.findItemDataArray(key: "itemArray") as? [ItemData] ?? []
        let sectionArray = createSectionArray(itemArray: itemArray)
        return sectionArray.count
    }
    
    // 月ごとにItemDataを分ける
    private func parseDateTimeTodoList(itemArray: [ItemData]) -> [String:[ItemData]] {
        var parsedDict: [String:[ItemData]]  = [:]
        let f = DateFormatter()
        f.timeStyle = .none
        f.dateStyle = .full
        f.locale = Locale(identifier: "ja_JP")
        for todo in itemArray {
            var tmpArray: [ItemData] = []
            if let month = todo.month {
                if !parsedDict.keys.contains(month) {
                    parsedDict[month] = []
                }
                tmpArray = parsedDict[month] ?? []
                tmpArray.append(todo)
                parsedDict[month] = tmpArray
            }
        }
        return parsedDict
    }
    
    // テーブルのセクション文言のリストを作成
    func createSectionArray(itemArray: [ItemData]) -> [String] {
        var sectionArray: [String] =  []
        for item in itemArray {
            if let month = item.month {
                if !sectionArray.contains(month) {
                    sectionArray.append(month)
                }
            }
        }
        return sectionArray
    }
}

