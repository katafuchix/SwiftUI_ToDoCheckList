//
//  ToDoItem.swift
//  SwiftUI_ToDoCheckList
//
//  Created by cano on 2024/01/30.
//

import Foundation

// ToDoリスト項目
// @Observableクラスで配列を@Observableにする場合は要素にも@Observableが必要
@Observable
class ToDoItem: Identifiable, Codable, Equatable, Hashable {
    
    var id = UUID()
    var name: String
    var note = ""
    var completedDate = Date.distantPast
    
    init() {
        name = ""
        note = ""
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
    
    init(name: String, note: String, completedDate: Date) {
        self.name = name
        self.note = note
        self.completedDate = completedDate
    }
    
    // Equatable
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ToDoItem {
    static var samples: [ToDoItem] {
        [
            ToDoItem(name: "犬の散歩"),
            ToDoItem(name: "猫と遊ぶ", note: "昼過ぎの公園"),
            ToDoItem(name: "納品", note: "提出済み", completedDate: Date())
        ]
    }
}
