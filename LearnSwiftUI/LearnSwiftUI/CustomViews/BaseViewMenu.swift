//
//  BaseViewMenu.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import SwiftUI

struct BaseNavigationView<Content>: View where Content: View {
    @Binding var menuClick: Bool

    var clickMenu = MenuClickedObservable.shared
    var imgBtnFirst: String? = nil
    var imgBtnSecond: String? = nil
    
    var menuAction: (() -> Void)? = nil
    var actionBtnFirst: (() -> Void)? = nil
    var actionBtnSecond: (() -> Void)? = nil
    var bgColor: Color = .white
    
    let content: Content
    
    var body : some View {
        ZStack {
            NavigationView {
                    content
                .background(bgColor)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        NavigationLeadingButton(imageString: "ic_menu",
                                                                action: {
                    self.menuAction?()
                }), trailing: NavigationTrailingButton(imgBtnFirst: imgBtnFirst,
                                                       imgBtnSecond: imgBtnSecond,
                                                      actionBtnFirst: actionBtnFirst,
                                                      actionBtnSecond: actionBtnSecond))
            }
        }.offset(y: self.menuClick ? 20 : 0)
        .background(bgColor)
    }
}


struct NavigationLeadingButton: View {
    var imageString: String
    var action: (() -> Void)?
    var body: some View {
        Button(action: action!) {
            Image(imageString)
                .resizable()
                .frame(width: 24, height:24)
        }
    }
}

struct NavigationTrailingButton: View {
    var imgBtnFirst: String? = nil
    var imgBtnSecond: String? = nil
    
    var actionBtnFirst: (() -> Void)? = nil
    var actionBtnSecond: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if imgBtnFirst != nil {
                Button(action: {
                    actionBtnFirst?()
                }) {
                    Image(imgBtnFirst!)
                        .resizable()
                        .frame(width: 24, height:24)
                }
            }
            
            if imgBtnSecond != nil {
                Button(action: {
                    actionBtnSecond?()
                }) {
                    Image(imgBtnSecond!)
                        .resizable()
                        .frame(width: 24, height:24)
                }
            }
        }
    }
}
