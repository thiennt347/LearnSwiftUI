//
//  DynamicFilteredView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/14/22.
//

import Foundation
import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    
    @FetchRequest var request: FetchedResults<T>
    
    let content: (T) -> Content
    
    init(dateFilter: Date, @ViewBuilder content: @escaping (T) -> Content) {
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: nil)
        self.content = content
    }
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No data found!")
                    .font(Font.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: -100)
            } else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
    
}
