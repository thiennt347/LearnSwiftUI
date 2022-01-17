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
    
    @EnvironmentObject var categoryVM: CategoryViewModel
    
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
                        CategoriesCollectionView(spacing: 16,
                                                 showIndicators: false)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Button(action: {
                        categoryVM.newCategory.toggle()
                    }, label: {
                        Image("ic_add_task")
                            .resizable()
                            .frame(width: 60, height: 60)
                    })
                    .padding(), alignment: .bottomTrailing
                ).fullScreenCover(isPresented: $categoryVM.newCategory, content: {
                    AddNewCategoryView()
                })
        )
    }
}
