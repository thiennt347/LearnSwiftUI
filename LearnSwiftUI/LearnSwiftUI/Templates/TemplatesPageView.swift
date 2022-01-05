//
//  TemplatesPageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct TemplatesPageView: View {
    @Binding var menuClick: Bool
    var menuAction: (() -> Void)?
    
    var body: some View {
        BaseNavigationView(menuClick: self.$menuClick,
                     menuAction: {
            withAnimation(.spring()) {
                self.menuClick.toggle()
            }
        }, content:
            Text("TemplatesPageView")
                .font(.title)
        )
    }
}
