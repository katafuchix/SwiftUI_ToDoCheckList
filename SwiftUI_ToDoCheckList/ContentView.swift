//
//  ContentView.swift
//  SwiftUI_ToDoCheckList
//
//  Created by cano on 2024/01/30.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataManager.self) var dataManager
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // 新規作成用 タイトル入力フォーム
                HStack {
                    TextField("New ToDo Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        // 新規ToDoItemを作成し、リストをリロード
                        dataManager.create(newItem)
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItem.isEmpty)
                }
                .padding([.leading, .trailing])
                
                // ToDoItemのリスト
                if !dataManager.toDoItemList.isEmpty {
                    List {
                        ForEach(dataManager.toDoItemList) { item in
                            @Bindable var item_b = item
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item_b.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                                    .padding(2)
                            }
                            .listRowSeparator(.hidden)
                            .onChange(of: item_b) { _,_ in
                                dataManager.saveList()
                            }
                        }
                        .onDelete { indexSet in // 削除時
                            dataManager.delete(indexSet: indexSet)
                        }
                    }
                    //.listStyle(.plain)
                } else {
                    Text("Add Your First ToDo Item.")
                    Image(systemName: "note.text").padding()
                    Spacer()
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("ToDo List")
            .navigationDestination(for: ToDoItem.self) { item in // 画面遷移
                DetailView(dataManager: dataManager, item: item)
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
        .environment(DataManager())
}
