//
//  CategoryPicker.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 2/9/22.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var showCategoryPicker: Bool
    @Binding var selected: CategoryDB
    
    @StateObject var categoryVM = CategoryViewModel.shared
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    List {
                        ForEach(categoryVM.categories, id: \.id) { category in
                            Button(action: {
                                self.selected = category
                            }, label: {
                                HStack(spacing: 10) {
                                    Image(systemName: category.imageName ?? "")
                                        .font(Font.system(size: 22))
                                        .padding()
                                        .foregroundColor(Color(hex: category.imageColor ?? ""))
                                    Text(category.name ?? "_")
                                    Text("\(category.tasks.count) tasks")
                                    Spacer()
                                }
                                .background(category == self.selected ? (.black.opacity(0.2)) : .white)
                            })
                            
                        }.listRowSeparator(.hidden)
                    }
                    .frame(height: 300)
                    Divider()
                    HStack {
                        Button(action: {
                            showCategoryPicker = false
                        }, label: {
                            Text("Save").bold()
                        })
                        
                    }
                    .padding(.horizontal)

                }
                .padding()
                .background(
                    Color.white
                        .cornerRadius(30)
                )
            }
            .padding()
        }
    }
}
