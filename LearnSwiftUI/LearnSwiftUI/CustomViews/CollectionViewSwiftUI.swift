//
//  CollectionViewSwiftUI.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/6/22.
//

import Foundation
import SwiftUI

struct Collection<Content: View, Data: Hashable>: View {
    @Binding var data: [Data]
    let showIndicators: Bool
    let viewBuilder: (Data) -> Content
    let cols: Int
    let spacing: CGFloat

    init(data: Binding<[Data]>,
         cols: Int = 3,
         spacing: CGFloat = 5,
         showIndicators: Bool = true,
         _ viewBuilder: @escaping (Data) -> Content) {
        _data = data
        self.cols = cols
        self.showIndicators = showIndicators
        self.spacing = spacing
        self.viewBuilder = viewBuilder
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: showIndicators) {
                self.setupView(geometry: geometry).frame(minHeight: geometry.frame(in: .global).height)
            }
        }
    }
    
    private func setupView(geometry: GeometryProxy) -> some View {
        let rowRemainder = Double(data.count).remainder(dividingBy: Double(cols))
        let rowCount = data.count / cols + (rowRemainder == 0 ? 0 : 1)

        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(0...rowCount-1, id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(0...self.cols-1, id: \.self) { col in
                        self.cell(colIndex: col, rowIndex: row)
                    }
                }
            }
            Spacer()
        }
    }
    
    private func cell(colIndex: Int, rowIndex: Int) -> some View {
        let cellIndex = (rowIndex * cols) + colIndex
        return ZStack {
            if cellIndex < data.count {
                self.viewBuilder(data[cellIndex])
            }
        }
    }
}
