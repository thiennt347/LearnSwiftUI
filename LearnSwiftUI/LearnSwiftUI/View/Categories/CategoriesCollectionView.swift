//
//  CategoriesCollectionView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/14/22.
//

import SwiftUI

struct CategoriesCollectionView: View {
    @FetchRequest(
      // 2.
      entity: CategoryDB.entity(),
      // 3.
      sortDescriptors: []
      //,predicate: NSPredicate(format: "genre contains 'Action'")
      // 4.
    ) var categoriesDB: FetchedResults<CategoryDB>
    
    let showIndicators: Bool
    let spacing: CGFloat
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var categoryVM = CategoryViewModel.shared

    init(spacing: CGFloat = 5,
         showIndicators: Bool = true) {
        self.showIndicators = showIndicators
        self.spacing = spacing
    }

    var body: some View {
        ScrollView(showsIndicators: showIndicators) {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(Array(self.categoriesDB.enumerated()), id: \.offset) { index, object in
                    NavigationLink {
                        ListsTaskPageView(index: index, categoryID: object.id ?? "")
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(systemName: object.imageName ?? "")
                                .foregroundColor(Color(hex: object.imageColor ?? ""))
                                .font(Font.system(size: 40, weight: .medium))
                                
                            Spacer()
                            Text(object.name ?? "")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Text("\(object.tasks.count) Tasks ")
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        .padding(20)
                        .background(.white)
                        .cornerRadius(8)
                    }
                }
            }
            .onAppear{
                self.categoryVM.categories = categoriesDB.map{ $0 }
            }
        }
    }
}

