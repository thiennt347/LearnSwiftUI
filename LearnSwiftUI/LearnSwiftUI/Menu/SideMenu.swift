//
//  SideMenu.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/4/22.
//

import SwiftUI

private func getHistoricalStocks() -> [Int] {
    
    return [20, 0, 30, 28, 40, 34, 38, 30]
}

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    
    //Menu button callBack
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image("icybay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                .padding(.top, 70)
                Spacer()
                Button {
                    self.action?()
                } label: {
                    Image(systemName: "chevron.backward.circle")
                        .foregroundColor(.white)
                        .font(Font.system(size: 40))
                }
            }.padding(.trailing, 20)
            
            HStack {
                Text("Joy MitChell")
                    .font(Font.system(size: 30, weight: .heavy))
                    .foregroundColor(.white)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(SideMenuViewModel.allCases, id: \.self) {
                    MenuButton(image: $0.imageName, title: $0.title, selectedTab: $selectedTab, animation: animation, action: self.action)
               }
                
            }
            .padding(.leading, -15)
            .padding(.top, 10)
            
            Spacer()
            VStack(alignment: .leading) {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 20))
                    for index in 0 ..< 8 {
                        path.addLine(to: CGPoint(x: ((index * 20) + 40), y: getHistoricalStocks()[index]))
                    }
                }.stroke(Color.white, lineWidth: 4.0)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .frame(maxWidth: UIScreen.screenWidth - 100, maxHeight: 300)
                    .clipped(antialiased: false)
                
                Text("nomal")
                    .font(Font.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                Text("Consistency")
                    .font(Font.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }.padding(.bottom, 60)
        }
        .padding(.leading, 30)
        .padding(.trailing, 100)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
