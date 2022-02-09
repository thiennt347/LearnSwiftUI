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
    @State var showDatePicker: Bool = false
    
    @State var showCategoryPicker: Bool = false
    
    @State var categorySelected: CategoryDB
    
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
                        
                        self.categoryVM.addTask(taskName: self.taskName,
                                                taskDate: self.taskDate,
                                                category: self.categorySelected,
                                                context: self.context)
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
                
                if showDatePicker {
                    DatePickerWithButtons(showDatePicker: $showDatePicker,
                                          savedDate: $taskDate,
                                          selectedDate: self.taskDate)
                        .transition(.opacity)
                }
                
                if showCategoryPicker {
                    CategoryPicker(showCategoryPicker: self.$showCategoryPicker, selected: self.$categorySelected)
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
                Button {
                    self.showDatePicker.toggle()
                } label: {
                    Text(self.taskDate.dateToString(dateFormat: "MMM dd, HH:mm"))
                }
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
