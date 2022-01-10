//
//  ListsTaskPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/10/22.
//

import SwiftUI

struct TestData: Identifiable {
    var id = UUID()
    var title: String
    var items: [String]
}

struct ListsTaskPageView: View {
    @Environment(\.presentationMode) var presentationMode
    let mygroups = [
            TestData(title: "Late", items: ["Call Max","Call Max","Call Max", "Call Max","Call Max","Call Max", "Call Max","Call Max","Call Max", "Call Max","Call Max","Call Max"]),
            TestData(title: "Today", items: ["Call Max","Call Max","Call Max"]),
            TestData(title: "Done", items: ["Call Max","Call Max","Call Max"])
        ]
    
    let data: CategoryModel
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                titleView
                ZStack {
                    Color.white
                    listTasks2
                }
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }.ignoresSafeArea(edges: .bottom)
        }.toolbar {
            NavigationTrailingButton(imgBtnFirst: "ic_search")
                .btnFirstTapped {
                    print("hello")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
            })
        )
    }
    
    var listTasks: some View {
        List {
            ForEach(mygroups) { gr in
                Section(header: Text(gr.title)) {
                    ForEach(gr.items, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
        .background(Color.white .ignoresSafeArea())
        .onAppear {
                // Set the default to clear
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    var listTasks2: some View {
        ScrollView(showsIndicators: false) {
            ForEach(mygroups) { gr in
                VStack(alignment: .leading, spacing: 20) {
                    Text(gr.title)
                    ForEach(gr.items, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
        .background(Color.white .ignoresSafeArea())
        .onAppear {
                // Set the default to clear
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: data.image)
                    .frame(width: 50,height: 50, alignment: .center)
                    .clipShape(Circle())
                    .foregroundColor(.blue)
                    .background(Color.white)
                Spacer()
            }
            Text(data.name)
                .font(Font.system(size: 40, weight: .heavy))
                .foregroundColor(.white)
            
            Text("\(data.numberTasks) tasks")
                .font(Font.system(size: 16, weight: .regular))
                .foregroundColor(.white)
        }.padding(.leading, 50)
        .padding(.trailing, 50)
        .padding(.top, 40)
        .padding(.bottom, 20)
    }
}
