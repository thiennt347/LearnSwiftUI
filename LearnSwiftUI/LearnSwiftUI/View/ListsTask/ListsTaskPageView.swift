//
//  ListsTaskPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/10/22.
//

import SwiftUI

struct ListsTaskPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskModel: TaskViewModel
    
    let category: CategoryDB
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                titleView
                ZStack {
                    Color.white
                    listTaskView(categoryID: category.id ?? "")
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
                AddNewTaskPage(category: category)
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
                Image(systemName: category.imageName ?? "")
                    .font(Font.system(size: 22))
                    .padding()
                    .foregroundColor(Color(hex: category.imageColor ?? ""))
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            
            Text(category.name ?? "")
                .font(Font.system(size: 40, weight: .heavy))
                .foregroundColor(.white)
            
            Text("\(category.totalTask) tasks")
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

struct listTaskView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest var request: FetchedResults<TaskDB>
    
    init(categoryID: String) {
        let predicate = NSPredicate(format: "categoryID = %@", categoryID)
        _request = FetchRequest(entity: TaskDB.entity(), sortDescriptors: [], predicate: predicate)
    }
    
    func deleteObject(object: TaskDB) {
        object.categoryDB?.totalTask -= 1
        
        context.delete(object)
        try? context.save()
    }
    
    var body: some View {
        List {
            if let late = request.filter{($0.taskDate ?? Date.now.startOfDay) < (Date.now.startOfDay)}, late.count > 0 {
                Section(header: ListTaskSection(title: "Late")) {
                    ForEach(late, id: \.id) { task in
                        TaskRow(data: task, title: "Late")
                            .swipeActions {
                                Button {
                                    self.deleteObject(object: task)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                }
                            }

                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }.textCase(nil)
            }
            
            if let today = request.filter{($0.taskDate ?? Date.now.startOfDay) >= (Date.now.startOfDay)}, today.count > 0 {
                Section(header: ListTaskSection(title: "Today")) {
                    ForEach(today, id: \.id) { task in
                        TaskRow(data: task, title: "Today")
                            .swipeActions {
                                Button {
                                    self.deleteObject(object: task)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                }
                            }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }.textCase(nil)
            }
            
            if let data = request.filter{$0.isComplete == true}, data.count > 0 {
                Section(header: ListTaskSection(title: "Done")) {
                    ForEach(data, id: \.id) { task in
                        TaskRow(data: task, title: "Done")
                            .swipeActions {
                                Button {
                                    self.deleteObject(object: task)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                }
                            }
                    }.listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }.textCase(nil)
            }
        }
        .listStyle(.grouped)
        .background(Color.white .ignoresSafeArea())
        .onAppear {
            // Set the default to clear
            UITableView.appearance().backgroundColor = .clear
        }
    }
}
