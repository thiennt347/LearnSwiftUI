//
//  AddNewTaskPage.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/13/22.
//

import SwiftUI

struct AddNewTaskPage: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var categoryVM =  CategoryViewModel()
    
    @Environment(\.managedObjectContext) var context
    
    @State var taskName: String = ""
    @State var taskDate: Date = Date.now
    
    @State var showCategoryPicker: Bool = false
    
    @State var categorySelected: CategoryDB
    
    @State var task: TaskDB?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("What are you planning?")
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
                        
                        if let task = self.task {
                            task.taskName = self.taskName
                            task.taskDate = self.taskDate
                            task.categoryDB = self.categorySelected
                            task.categoryID = self.categorySelected.id
                            try? context.save()
                        } else {
                            self.categoryVM.addTask(taskName: self.taskName,
                                                    taskDate: self.taskDate,
                                                    category: self.categorySelected,
                                                    context: self.context)
                        }
                        self.dismiss()
                    } label: {
                        Text(self.task == nil ? "Create"  : "Edit")
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
                
                if showCategoryPicker {
                    CategoryPicker(showCategoryPicker: self.$showCategoryPicker, selected: self.$categorySelected)
                }
            }
            .navigationTitle(self.task == nil ? "New task"  : "Edit task")
            .navigationBarItems(trailing: trailingBtn)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let task = self.task {
                    self.taskName = task.taskName ?? ""
                    self.taskDate = task.taskDate ?? Date.now
                    self.categorySelected = task.categoryDB!
                }
            }
            
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
                DatePicker("Please enter a date", selection: $taskDate)
                  .labelsHidden()
                  .padding(.vertical)
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
                Button {
                    self.showCategoryPicker.toggle()
                } label: {
                    Text("Category")
                }

            }.frame(height: 40)
            .hLeading()
            .foregroundColor(.gray)
            
        }.hLeading()
    }
}
