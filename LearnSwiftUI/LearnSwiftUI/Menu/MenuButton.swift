//
//  MenuButton.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/4/22.
//

import SwiftUI

struct MenuButton: View {
    var image: String
    var title: String
    //Selected
    @Binding var selectedTab: String
    //Animation
    var animation: Namespace.ID
    //CallBack
    var action: (() -> Void)?
    
    var body: some View {
        
        Button(action: {
            self.selectedTab = title
            self.action?()
        }) {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(Font.system(size: 18, weight: .medium))
                Text(title)
                    .font(Font.system(size: 16, weight: .regular))
            }
            .foregroundColor(selectedTab == title ? Color("blue") : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Color.white.opacity(selectedTab == title ? 1 : 0)
            )
        }
        .cornerRadius(8)
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
