//
//  LearnSwiftUIRow.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI

struct LearnSwiftUIRow: View {
    var data: LearnSwiftModel
    
    var body: some View {
        
        HStack {
            data.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(data.name)

            Spacer()
        }
    }
}

struct LearnSwiftUIRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LearnSwiftUIRow(data: learnSwiftUIDatas[0])
            LearnSwiftUIRow(data: learnSwiftUIDatas[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
