//
//  LearnSwiftUIList.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI

struct LearnSwiftUIList: View {
    var body: some View {
        NavigationView {
            List(learnSwiftUIDatas, id: \.id) { data in
                NavigationLink {
                    Detail(data: data)
                } label: {
                    LearnSwiftUIRow(data: data)
                }
            }
        }.navigationTitle("hello")
    }
}

struct LearSwiftUIList_Previews: PreviewProvider {
    static var previews: some View {
        LearnSwiftUIList()
    }
}
