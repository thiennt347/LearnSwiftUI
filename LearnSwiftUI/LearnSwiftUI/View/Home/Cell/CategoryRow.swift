//
//  CategoryRow.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import Foundation
import SwiftUI

struct CategoryItem: View {
    let item: HorizontalData
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 10) {
                Spacer().frame(height: 0)
                Text(item.title)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color.gray)
                Text(item.name)
                    .font(Font.system(size: 20, weight: .bold))
                ProgressView(value: CGFloat(item.progress)).tint(item.progress > 0.5 ? Color.purple : Color.blue)
                    
                
            }
            .frame(width: 150, height: 90)
            .padding()
            .background(Color.white)
        }.cornerRadius(10)
    }
}
