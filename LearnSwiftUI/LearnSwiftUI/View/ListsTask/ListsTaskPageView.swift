//
//  ListsTaskPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/10/22.
//

import SwiftUI

struct ListsTaskPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var categoryVM = CategoryViewModel.shared
    @State var taskSelected: TaskDB?
    
    @Environment(\.managedObjectContext) var context

    let index: Int
    
    @FetchRequest var tasks: FetchedResults<TaskDB>
    
    init(index: Int, categoryID: String) {
        self.index = index
        let predicate = NSPredicate(format: "categoryID = %@", categoryID)
        _tasks = FetchRequest(entity: TaskDB.entity(), sortDescriptors: [], predicate: predicate)
    }

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                titleView
                ZStack {
                    Color.white
                    listTaskView
                }
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay(
                Button(action: {
                    categoryVM.addNewTask.toggle()
                }, label: {
                    Image("ic_add_task")
                        .resizable()
                        .frame(width: 60, height: 60)
                }).padding(), alignment: .bottomTrailing
            ).fullScreenCover(isPresented: $categoryVM.addNewTask) {
                AddNewTaskPage(categorySelected: self.categoryVM.categories[index], task: taskSelected)
            }.fullScreenCover(isPresented: $categoryVM.editTask) {
                AddNewTaskPage(categorySelected: self.categoryVM.categories[index], task: taskSelected)
            }
            
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
                Image(systemName: self.categoryVM.categories[index].imageName ?? "")
                    .font(Font.system(size: 22))
                    .padding()
                    .foregroundColor(Color(hex: self.categoryVM.categories[index].imageColor ?? ""))
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            
            Text(self.categoryVM.categories[index].name ?? "")
                .font(Font.system(size: 40, weight: .heavy))
                .foregroundColor(.white)
            
            Text("\(self.categoryVM.categories[index].tasks.count) tasks")
                .font(Font.system(size: 16, weight: .regular))
                .foregroundColor(.white)
        }
        .padding(.leading, 50)
        .padding(.trailing, 50)
        .padding(.top, 40)
        .padding(.bottom, 20)
        .hLeading()
    }
    
    func deleteTask(at indexSets: IndexSet) {
        indexSets.forEach { index in
            self.context.delete(self.tasks[index])
        }
        try? context.save()
    }
    
    var listTaskView: some View {
        List {
            if let late = self.tasks.filter{(($0.taskDate ?? Date.now.startOfDay) < (Date.now.startOfDay)) && ($0.isComplete == false)}, late.count > 0 {
                Section(header: ListTaskSection(title: "Late")) {
                    ForEach(late, id: \.id) { task in
                        Button {
                            self.taskSelected = task
                            self.categoryVM.editTask.toggle()
                        } label: {
                            TaskRow(data: task, title: "Late")
                        }
                    }
                    .onDelete(perform: deleteTask)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }.textCase(nil)
            }
            
            if let today = self.tasks.filter{(($0.taskDate ?? Date.now.startOfDay) >= (Date.now.startOfDay)) && ($0.isComplete == false)}, today.count > 0 {
                Section(header: ListTaskSection(title: "Today")) {
                    ForEach(today, id: \.id) { task in
                        Button {
                            self.taskSelected = task
                            self.categoryVM.editTask.toggle()
                        } label: {
                            TaskRow(data: task, title: "Today")
                        }
                    }
                    .onDelete(perform: deleteTask)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }.textCase(nil)
            }
            
            if let data = self.tasks.filter{$0.isComplete == true}, data.count > 0 {
                Section(header: ListTaskSection(title: "Done")) {
                    ForEach(data, id: \.id) { task in
                        TaskRow(data: task, title: "Done")
                    }
                    .onDelete(perform: deleteTask)
                    .listRowInsets(EdgeInsets())
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
