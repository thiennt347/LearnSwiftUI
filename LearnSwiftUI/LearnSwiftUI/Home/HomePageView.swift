//
//  HomePageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI
let categories = [HorizontalData(id: 1, title: "kd Tasks", name: "Business", progress: 0.7), HorizontalData(id: 2, title: "k0 Tasks", name: "Personal", progress: 0.5), HorizontalData(id: 3, title: "kz Tasks", name: "Team Task", progress: 1)]

let todayTasks = [TodayTask(id: 1, status: 0, name: "Daily meeting with team", taskType: TaskType.Business.rawValue), TodayTask(id: 2, status: 1, name: "Pay for your friend", taskType: TaskType.Personal.rawValue), TodayTask(id: 3, status: 0, name: "Check Emails", taskType: TaskType.Personal.rawValue), TodayTask(id: 4, status: 0, name: "Lunch with Thien", taskType: TaskType.Business.rawValue), TodayTask(id: 5, status: 0, name: "Mutation", taskType: TaskType.Personal.rawValue)]

struct HomePageView: View {
    var body: some View {
        NavigationView {
            homeContent
            .background(Color.black.opacity(0.03))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: menuButton, trailing: leadingButton)
        }
        
    }
}

private var homeContent: some View {
    ScrollView {
        VStack(alignment: .leading) {
            Text("What's up, Joy!")
                .font(Font.system(size: 30, weight: .bold))
            Spacer()
                .frame(minHeight: 20, maxHeight: .infinity)
            Text("CATEGOTIES")
                .font(Font.system(size: 16, weight: .bold))
                .foregroundColor(Color.gray)
            HorizontalList
            Spacer().frame(height: 30)
            Text("Today's Task")
                .font(Font.system(size: 16, weight: .bold))
                .foregroundColor(Color.gray)
            TodayTaskList
        }
        .padding(30)
        Spacer()
        HStack {
            Spacer()
            Button(action: {
                //Todo Add task
            }) {
                HStack {
                    Image("ic_add_task")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
                .padding(20)
                .background(Color.clear)
            }.frame(width: 70, height: 70)
        }.padding(20)
    }
}

private var HorizontalList: some View {
    ScrollView (.horizontal, showsIndicators: false) {
         HStack {             
             ForEach(categories, id: \.self) {
                 CategoryItem(item: $0)
            }
         }
    }.frame(height: 140)
}

private var TodayTaskList: some View {
    VStack {
        ForEach(todayTasks, id: \.self) {
            TodayTaskItem(item: $0)
       }
    }
}

private var leadingButton: some View {
    HStack(alignment: .center, spacing: 16) {
        Button(action: {
            print("settingsButton")

        }) {
            Image("ic_search")
                .resizable()
                .frame(width: 24, height:24)
        }
        
        Button(action: {
            print("settingsButton")

        }) {
            Image("ic_notification")
                .resizable()
                .frame(width: 24, height:24)
        }
    }
}

private var menuButton: some View {
    Button(action: {
        print("menuButton")

    }) {
        Image("ic_menu")
            .resizable()
            .frame(width: 24, height:24)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
