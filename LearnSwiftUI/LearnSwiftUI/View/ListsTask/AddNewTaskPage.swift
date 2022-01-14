//
//  AddNewTaskPage.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/13/22.
//

import SwiftUI

struct AddNewTaskPage: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var taskModel = TaskViewModel.shared
    @Environment(\.managedObjectContext) var context
    
    @State var taskName: String = ""
    var category: CategoryDB
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("What are you planing?")
                            .font(Font.system(size: 18))
                            .hLeading()
                            .foregroundColor(.gray)
                        MultilineTextView(text: $taskName)
                            .frame(height: 200)
                            .disableAutocorrection(true)
                        Divider()
                        addTaskOption
                    }.padding(40)
                    Spacer()
                    
                    Button {
                        if self.taskName.isEmpty {
                            return
                        }
                        let taskDB = TaskDB(context: self.context)
                        taskDB.id = UUID().uuidString
                        taskDB.taskName = taskName
                        taskDB.taskDate = Date.now
                        taskDB.categoryID = category.id
                        taskDB.categoryDB = category
                        taskDB.categoryDB?.totalTask += 1
                        
                        try? context.save()
                        self.dismiss()
                    } label: {
                        Text("Create")
                            .foregroundColor(self.taskName.isEmpty ? .black.opacity(0.5) : .white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .disabled(self.taskName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(self.taskName.isEmpty ? .gray.opacity(0.5) : Color.blue)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .navigationTitle("New task")
            .navigationBarItems(trailing: trailingBtn)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var trailingBtn: some View {
        Button(action: {
            self.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.black)
        })
    }
    
    var addTaskOption: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "bell")
                    .foregroundColor(.blue)
                Text(Date.now.dateToString(dateFormat: "MMM DD, HH:mm"))
            }
            .frame(height: 40)
            .hLeading()
            
            HStack(spacing: 10) {
                Image(systemName: "note")
                Text("Add Note")
            }.frame(height: 40)
            .hLeading()
            .foregroundColor(.gray)
            
            HStack(spacing: 10) {
                Image(systemName: "tag")
                Text("Category")
            }.frame(height: 40)
            .hLeading()
            .foregroundColor(.gray)
            
        }.hLeading()
    }
}
