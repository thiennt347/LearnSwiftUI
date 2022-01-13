//
//  ListsTaskPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/10/22.
//

import SwiftUI

struct ListsTaskPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var taskModel = TaskViewModel.shared
    
    let category: CategoryModel
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                titleView
                ZStack {
                    Color.white
                    List {
                        ForEach(Array($taskModel.taskData.enumerated()), id: \.offset) { indexSection, section in
                            Section(header:
                                        ListTaskSection(data: section)
                            ) {
                                ForEach(Array(section.items.enumerated()), id: \.offset) { indexRow, row in
                                    TaskRow(data: row, section: section)
                                        .swipeActions {
                                            Button {
                                                taskModel.taskData[indexSection].items.remove(at: indexRow)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                }
                            }
                            .textCase(nil)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .padding(.top, 10)
                    .listStyle(.grouped)
                    .background(Color.white .ignoresSafeArea())
                    .onAppear {
                        // Set the default to clear
                        UITableView.appearance().backgroundColor = .clear
                    }
                }
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay(
                Button(action: {
                    taskModel.addNewTask.toggle()
                }, label: {
                    Image("ic_add_task")
                        .resizable()
                        .frame(width: 60, height: 60)
                }).padding(), alignment: .bottomTrailing
            ).fullScreenCover(isPresented: $taskModel.addNewTask) {
                AddNewTaskPage()
            }
            
        }
        .onAppear {
            print("onAppear")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: leadingBtn, trailing: trailingBtn)
    }
    
    var trailingBtn: some View {
        Button(action: {
            print("More")
        }, label: {
            Image(systemName: "ellipsis")
                .foregroundColor(Color.white)
        })
    }
    
    var leadingBtn: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .foregroundColor(Color.white)
        })
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            VStack {
                Image(systemName: category.image)
                    .font(Font.system(size: 22))
                    .padding()
                    .foregroundColor(category.imageColor)
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            
            Text(category.name)
                .font(Font.system(size: 40, weight: .heavy))
                .foregroundColor(.white)
            
            Text("\(category.numberTasks) tasks")
                .font(Font.system(size: 16, weight: .regular))
                .foregroundColor(.white)
        }
        .padding(.leading, 50)
        .padding(.trailing, 50)
        .padding(.top, 40)
        .padding(.bottom, 20)
        .hLeading()
    }
}


struct TaskRow: View {
    @Binding var data: Task
    @Binding var section: TaskSection
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if data.isDone {
                    Text(data.title)
                        .strikethrough()
                        .font(Font.system(size: 16))
                        .foregroundColor(.blue)
                } else {
                    Text(data.title)
                        .font(Font.system(size: 16, weight: .regular))
                }
                
                Text(data.date.dateToString(dateFormat: "HH:mm"))
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundColor(section.title == "Late" ? Color.red : .gray)
            }
            .hLeading()
            
            Image(systemName: data.isDone ? "checkmark.square.fill" : "square")
                .foregroundColor(data.isDone ? Color(UIColor.systemBlue) : Color.gray)
                .font(Font.system(size: 24))
                .onTapGesture {
                    if section.title == "Done" {
                        return
                    }
                    data.isDone.toggle()
                }
        }
        .opacity(section.title == "Done" ? 0.5 : 1)
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

struct ListTaskSection: View {
    @Binding var data: TaskSection
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.title)
                .font(Font.system(size: 14))
                .foregroundColor(.gray)
        }
        .opacity(data.title == "Done" ? 0.5 : 1)
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.top, 20)
    }
}

