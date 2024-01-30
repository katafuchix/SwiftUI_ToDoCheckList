//
//  DataManager.swift
//  SwiftUI_ToDoCheckList
//
//  Created by cano on 2024/01/30.
//

import Foundation
import SwiftUI
import Observation

// データ保存マネージャクラス
@Observable class DataManager {
    var toDoItemList: [ToDoItem] = []
    
    // データ保存はJsonで行う
    let fileURL = URL.documentsDirectory.appending(path: "toDoItemList.json")
    
    init() {
        loadItems()
    }
    
    // Jsonロード
    func loadItems() {
        //toDoItemList = ToDoItem.samples
        
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                toDoItemList = try JSONDecoder().decode([ToDoItem].self, from: data)
            } catch {
                // The file is corrupt so currently the bucketList is empty so store it and replace the damaged file
                saveList()
            }
        }
    }
    
    // 更新
    func update(item: ToDoItem, note: String, completedDate: Date) {
        if let index = toDoItemList.firstIndex(where: {$0.id == item.id}) {
            toDoItemList[index].note = note
            toDoItemList[index].completedDate = completedDate
            saveList()
        }
    }
    
    // 保存 配列をJsonファイルに保存
    func saveList() {
        do {
            let toDoItemListData = try JSONEncoder().encode(toDoItemList)
            let toDoItemListString = String(decoding: toDoItemListData, as: UTF8.self)
            try toDoItemListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not encode todo list and save it.")
        }
    }
    
    // 新規作成
    func create(_ newName: String) {
        let toDoItem = ToDoItem()
        toDoItem.name = newName
        toDoItemList.append(toDoItem)
        saveList()
    }
    
    // 削除
    func delete(indexSet: IndexSet) {
        toDoItemList.remove(atOffsets: indexSet)
        saveList()
    }
}

