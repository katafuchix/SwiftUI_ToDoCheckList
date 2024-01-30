//
//  SwiftUI_ToDoCheckListApp.swift
//  SwiftUI_ToDoCheckList
//
//  Created by cano on 2024/01/30.
//

import SwiftUI

@main
struct SwiftUI_ToDoCheckListApp: App {
    @State private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(dataManager)
        }
    }
}
