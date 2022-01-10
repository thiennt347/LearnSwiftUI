//
//  SettingsPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct SettingsPageView: View {
    @ObservedObject var clickOb = MenuClickedObservable.shared
    
    var body: some View {
        BaseNavigationView(
            menuClick: $clickOb.menuClick,
            menuAction: {
            withAnimation(.spring()) {
                self.clickOb.menuClick.toggle()
            }
        }, content:
            Text("SettingsPageView")
                .font(.title)
        )
    }
}
