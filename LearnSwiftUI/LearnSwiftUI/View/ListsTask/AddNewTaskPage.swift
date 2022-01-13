//
//  AddNewTaskPage.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/13/22.
//

import SwiftUI

struct AddNewTaskPage: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var taskModel = TaskViewModel.shared

    @State var taskDesc: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("What are you planing?")
                            .font(Font.system(size: 18))
                            .hLeading()
                            .foregroundColor(.gray)
                        MultilineTextView(text: $taskDesc)
                            .frame(height: 200)
                            .disableAutocorrection(true)
                        Divider()
                        addTaskOption
                    }.padding(40)
                    Spacer()
                    
                    Button {
                        if self.taskDesc.isEmpty {
                            return
                        }
                        taskModel.taskData[1].items.append(Task(title: taskDesc, date: Date.now))
                        self.dismiss()
                    } label: {
                        Text("Create")
                            .foregroundColor(self.taskDesc.isEmpty ? .black.opacity(0.5) : .white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .disabled(self.taskDesc.isEmpty)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(self.taskDesc.isEmpty ? .gray.opacity(0.5) : Color.blue)
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

struct AddNewTaskPage_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskPage()
    }
}
