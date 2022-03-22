//
//  Hello.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 3/4/22.
//

import Foundation

struct Hello {
    var lists: [String]
    var aida: String?
    
    mutating func addData(data: String) {
        self.lists.append(data)
    }
    
    mutating func removeList(index: Int) {
        self.lists.remove(at: index)
    }
}
