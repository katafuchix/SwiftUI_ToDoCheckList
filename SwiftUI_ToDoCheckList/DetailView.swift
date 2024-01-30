//
//  DetailView.swift
//  SwiftUI_ToDoCheckList
//
//  Created by cano on 2024/01/30.
//

import SwiftUI

struct DetailView: View {
    @Bindable var dataManager: DataManager
    let item: ToDoItem
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Note", text: $note, axis: .vertical)
            if completedDate != Date.distantPast {
                DatePicker("Completed on", selection: $completedDate, displayedComponents: .date)
            }
            Button(completedDate == Date.distantPast ? "Add Date" : "Clear Date") {
                if completedDate == Date.distantPast {
                    completedDate = Date()
                } else {
                    completedDate = Date.distantPast
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.black)
        }
        .onAppear {
            note = item.note
            completedDate = item.completedDate
        }
        .toolbar {
            ToolbarItem {
                Button("Update") { // 更新処理
                    dataManager.update(item: item, note: note, completedDate: completedDate)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
            }
        }
        .navigationTitle(item.name)
    }
}


#Preview {
    NavigationStack{
        DetailView(dataManager: DataManager(), item: ToDoItem.samples[2])
    }
}

