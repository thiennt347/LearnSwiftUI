//
//  AddNewCategoryView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/14/22.
//

import SwiftUI

struct AddNewCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var category = CategoryViewModel.shared

    @State var categoryName: String = ""
    @State private var icon = "message"
    @State private var color: Color = .gray
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("What are you category?")
                            .font(Font.system(size: 18))
                            .hLeading()
                            .foregroundColor(.gray)
                        MultilineTextView(text: $categoryName)
                            .frame(height: 200)
                            .disableAutocorrection(true)
                        Divider()
                        addTaskOption
                    }.padding(40)
                    Spacer()
                    
                    Button {
                        if self.categoryName.isEmpty {
                            return
                        }
                        
                        let categoryDB = CategoryDB(context: self.context)
                        categoryDB.id = UUID().uuidString
                        categoryDB.imageColor = self.color.hexaRGB
                        categoryDB.imageName = self.icon
                        categoryDB.name = self.categoryName
                        
                        try? context.save()
                        
                        self.dismiss()
                    } label: {
                        Text("Create")
                            .foregroundColor(self.categoryName.isEmpty ? .black.opacity(0.5) : .white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    }
                    .disabled(self.categoryName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(self.categoryName.isEmpty ? .gray.opacity(0.5) : Color.blue)
                    .cornerRadius(10)
                    .padding()
                }
                .sheet(isPresented: $category.pickerImage) {
                    SFSymbolsPicker(icon: $icon, axis: .vertical, haptic: true)
                }
            }
            .navigationTitle("New Category")
            .navigationBarItems(trailing: trailingBtn)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var trailingBtn: some View {
        Button(action: {
            self.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.black)
        })
    }
    
    var addTaskOption: some View {
        VStack(spacing: 10) {
            Button {
                category.pickerImage.toggle()
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: icon)
                        .font(Font.system(size: 30))
                        .foregroundColor(self.color)
                    Text("Icon picker")
                }.frame(height: 40)
                .hLeading()
                .foregroundColor(.gray)
            }

            HStack(spacing: 16) {
                SquareColorPickerView(colorValue: $color)
                Text("Color Picker")
                    .foregroundColor(.gray)
            }.frame(height: 40)
            .hLeading()
            
        }.hLeading()
    }
}

struct AddNewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCategoryView()
    }
}

struct SquareColorPickerView: View {
    
    @Binding var colorValue: Color
    
    var body: some View {
        
        colorValue
            .frame(width: 20, height: 20, alignment: .center)
            .cornerRadius(10.0)
            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.white, style: StrokeStyle(lineWidth: 5)))
            .padding(10)
            .background(AngularGradient(gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]), center:.center).cornerRadius(20.0))
            .overlay(ColorPicker("", selection: $colorValue).labelsHidden().opacity(0.015))
            .shadow(radius: 5.0)

    }
}
