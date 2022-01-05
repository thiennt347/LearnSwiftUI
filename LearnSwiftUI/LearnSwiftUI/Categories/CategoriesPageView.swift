//
//  CategoriesPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct CategoriesPageView: View {
    @Binding var menuClick: Bool
    var menuAction: (() -> Void)?
    
    var body: some View {
        BaseNavigationView(
            menuClick: self.$menuClick,
            imgBtnFirst: "ic_search",
            menuAction: {
                withAnimation(.spring()) {
                    self.menuClick.toggle()
                }
            }, actionBtnFirst: {
                print("Search action")
            }, content:
                Text("CategoriesPageView")
                    .font(.title)
        )
    }
}

