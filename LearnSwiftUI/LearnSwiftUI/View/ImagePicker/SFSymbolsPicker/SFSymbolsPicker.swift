//
//  SFSymbolsPicker.swift
//
//
//  Created by Alessio Rubicini on 05/01/21.
//

import SwiftUI
import Foundation

public struct SFSymbolsPicker: View {
    
    // MARK: - View properties
    @Environment(\.dismiss) var dismiss
    @Binding public var icon: String
    @State var category: CategoryImage = .exsample
    let axis: Axis.Set
    let haptic: Bool
    
    /// Show a picker to select SF Symbols
    /// - Parameters:
    ///   - icon: A binding to a String value that determines which icon has been selected
    ///   - category: Custom enum Category that determines which type of icons should be displayed
    ///   - axis: ScrollView axis (vertical by default)
    ///   - haptic: If true a small haptic feedback is generated when an icon is selected (true by default)
    public init(icon: Binding<String>, axis: Axis.Set = .horizontal, haptic: Bool = true) {
        self._icon = icon
        self.axis = axis
        self.haptic = haptic
    }

    
    // MARK: - View body
    
    public var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView(self.axis) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 20) {
                            ForEach(symbols[category.rawValue]!, id: \.hash) { icon in
                                
                                Image(systemName: icon)
                                    .font(.system(size: 25))
                                    .foregroundColor(self.icon == icon ? Color.blue : Color.primary)
                                    .onTapGesture {
                                        
                                        // Assign binding value
                                        withAnimation {
                                            self.icon = icon
                                        }
                                        
                                        // Generate haptic
                                        if self.haptic {
                                            self.impactFeedback(style: .medium)
                                        }
                                    }
                                
                            }.padding(.top, 20)
                        }
                    }
                    
                    Spacer()
                    horizontalCategories
                }
            }
            .navigationTitle("SFSymbolsPicker")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: leadingBtn)
        }
    }
    
    private var horizontalCategories: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(CategoryImage.allCases, id: \.self) { item in
                    Text(item.rawValue)
                        .frame(height: 40, alignment: .center)
                        .padding(.leading, 6)
                        .padding(.trailing, 6)
                        .foregroundColor(self.category == item ? .white : .black)
                        .background(self.category == item ? .blue : .gray.opacity(0.5))
                        .cornerRadius(10)
                        .onTapGesture {
                            self.category = item
                            print("hello")
                        }
                }
            }
        }.padding()
    }

    
    var leadingBtn: some View {
        Button {
            self.dismiss()
        } label: {
            Text("Save")
                .font(Font.system(size: 16, weight: .medium))
        }

    }
    
    private func impactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}




struct SFSymbolsPicker_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolsPicker(icon: .constant(""), axis: .horizontal)
    }
}
