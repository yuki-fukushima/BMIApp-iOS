//
//  AccessDataBase.swift
//  BMIApp
//
//  Created by cries on 2019/04/05.
//  Copyright © 2019年 cries. All rights reserved.
//

import Foundation
class AccessDataBase {
    // シリアライズしてDBに保存する
    static func save<T>(key: String, value: T) {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    }
    
    // デシリアライズしてDBからArray<ItemData>を取得する
    static func findItemDataArray(key: String) -> Array<Any>? {
        if let loadedData = UserDefaults().data(forKey: key) {
            let object = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as! Array<ItemData>
            return object
        } else {
            return nil
        }
    }
}


