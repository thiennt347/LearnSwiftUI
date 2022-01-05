//
//  MainView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/4/22.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = "Home"
    @State var menuClick = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            SideMenu(selectedTab: $selectedTab) {
                withAnimation(.spring()) {
                    self.menuClick = false
                }
            }
            GeometryReader { geometry in
                ZStack {
                    Home(selectedTab: $selectedTab, menuClick: self.$menuClick)
                        .cornerRadius(self.menuClick ? 30 : 0)
                }.offset(x: self.menuClick ? (geometry.size.width - 80) : 0, y: 0)
                .scaleEffect(self.menuClick ? 0.84 : 1)
                .ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
