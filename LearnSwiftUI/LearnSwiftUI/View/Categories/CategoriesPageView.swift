//
//  CategoriesPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct CategoriesPageView: View {
    @State var actionBtnFirst = false
    @ObservedObject var clickOb = MenuClickedObservable.shared
    
    @StateObject var categories = CategoryViewModel.shared
    
    var body: some View {
        BaseNavigationView(
            menuClick: $clickOb.menuClick,
            menuAction: {
                withAnimation(.spring()) {
                    self.clickOb.menuClick.toggle()
                }
            }, bgColor: Color.black.opacity(0.03),
            content:
                ZStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Lists")
                                .font(Font.system(size: 28, weight: .bold))
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.leading, 20)
                        listsCategories
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
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
                    .padding(.bottom, 40)
                }
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    private var listsCategories: some View {
        Collection(data: $categories.categories,
                   cols: 2,
                   spacing: 16,
                   showIndicators: false) { data in
            ZStack {
                NavigationLink {
                    ListsTaskPageView(category: data)
                } label: {
                    CategotiesViewCell(data: data)
                }
            }
        }.padding(.top, 10)
    }
}
