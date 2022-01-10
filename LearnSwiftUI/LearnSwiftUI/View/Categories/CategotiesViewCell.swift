//
//  CategotiesViewCell.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/6/22.
//

import SwiftUI

struct CategotiesViewCell: View {
    let data: CategoryModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: data.image)
                .foregroundColor(data.imageColor)
                .font(Font.system(size: 40, weight: .medium))
                
            Spacer()
            Text(data.name)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("\(data.numberTasks) Tasks ")
                .font(Font.system(size: 14))
                .foregroundColor(Color.gray)
        }
        .padding(20)
        .background(.white)
        .cornerRadius(8)
    }
}
