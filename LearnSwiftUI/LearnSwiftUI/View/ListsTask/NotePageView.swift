//
//  NotePageView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 2/23/22.
//

import SwiftUI

struct NotePageView: View {
    @Binding var note: String
    @State private var showingImagePicker = false
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("What are you note?")
                        .font(Font.system(size: 18))
                        .foregroundColor(.gray)
                    MultilineTextView(text: $note)
                        .frame(height: 200)
                        .disableAutocorrection(true)
                    
                    VStack(spacing: 20) {
                        Button {
                            self.sourceType = .camera
                            self.showingImagePicker = true
                        } label: {
                            Text("Camera picker for attachment")
                        }
                        
                        Button {
                            self.sourceType = .photoLibrary
                            self.showingImagePicker = true
                        } label: {
                            Text("Photo picker for attachment")
                        }
                    }.hLeading()
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 300, height: 300)
                    }
                    Spacer()
                }
                .hLeading()
                .padding(40)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePickerView(selectedImage: $selectedImage, sourceType: $sourceType)
            }
            .navigationTitle("Add Note")
            .navigationBarItems(trailing: trailingBtn)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var trailingBtn: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.black)
        })
    }
}
