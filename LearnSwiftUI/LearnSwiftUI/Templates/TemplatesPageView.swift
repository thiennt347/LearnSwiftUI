//
//  TemplatesPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct TemplatesPageView: View {
    @ObservedObject var clickOb = MenuClickedObservable.shared
    
    var body: some View {
        BaseNavigationView(
            menuClick: $clickOb.menuClick,
            menuAction: {
            withAnimation(.spring()) {
                self.clickOb.menuClick.toggle()
            }
        }, content:
            Text("TemplatesPageView")
                .font(.title)
        )
    }
}
