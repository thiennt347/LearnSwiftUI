//
//  HomePageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI
let categories = [HorizontalData(id: 1, title: "20 Tasks", name: "Business", progress: 0.7), HorizontalData(id: 2, title: "10 Tasks", name: "Personal", progress: 0.5), HorizontalData(id: 2, title: "10 Tasks", name: "IMP Task", progress: 0.5)]

let todayTasks = [TodayTask(id: 1, status: 0, name: "Daily meeting with team", taskType: TaskType.Business.rawValue), TodayTask(id: 2, status: 1, name: "Pay for your friend", taskType: TaskType.Personal.rawValue), TodayTask(id: 3, status: 0, name: "Check Emails", taskType: TaskType.Personal.rawValue), TodayTask(id: 4, status: 0, name: "Lunch with Thien", taskType: TaskType.Business.rawValue), TodayTask(id: 5, status: 0, name: "Mutation", taskType: TaskType.Personal.rawValue)]

struct HomePageView: View {
    @Binding var menuClick: Bool
    var menuAction: (() -> Void)?
    var body: some View {
        BaseNavigationView(
            menuClick: self.$menuClick,
            imgBtnFirst: "ic_search",
            imgBtnSecond: "ic_notification",
            menuAction: {
                withAnimation(.spring()) {
                    self.menuClick.toggle()
                }
            }, actionBtnFirst: {
                print("Search action")
            }, actionBtnSecond: {
                print("Notification action")
            },
            bgColor: Color.black.opacity(0.03),
            content:
                homeContent
        )
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private var homeContent: some View {
    ZStack {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("What's up, Joy!")
                    .font(Font.system(size: 36, weight: .bold))
                    .padding(30)
                
                VStack(alignment: .leading) {
                    Text("CATEGOTIES")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color.gray)
                    HorizontalList
                }.padding(.leading, 30)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today's Task")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color.gray)
                    TodayTaskList
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding(.trailing, 30)
                .padding(.leading, 30)
                
            }
        }
        
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                Spacer()
                Button(action: {
                    //Todo Add task
                }) {
                    Image("ic_add_task")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
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
