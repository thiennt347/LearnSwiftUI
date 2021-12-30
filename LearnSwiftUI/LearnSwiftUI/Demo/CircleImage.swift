//
//  CircleImage.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .frame(width: 300,height: 300, alignment: .center)
            .padding()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color.blue, lineWidth: 2)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
