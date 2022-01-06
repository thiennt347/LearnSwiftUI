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
    
    var body: some View {
        BaseNavigationView(
            menuClick: $clickOb.menuClick,
            imgBtnFirst: "ic_search",
            menuAction: {
                withAnimation(.spring()) {
                    self.clickOb.menuClick.toggle()
                }
            }, actionBtnFirst: {
                self.actionBtnFirst = true
            }, content:
                VStack {
                    Text("CategoriesPageView")
                        .font(.title)
                    
                    NavigationLink(destination:
                        LearnSwiftUIList(),
                        isActive: self.$actionBtnFirst) {
                            Text("")
                    }.hidden()
                }
        )
    }
}
