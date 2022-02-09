//
//  DatePickerView.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 2/9/22.
//

import SwiftUI

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Divider()
                    HStack {
                        Button(action: {
                            showDatePicker = false
                        }, label: {
                            Text("Cancel")
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            savedDate = selectedDate
                            showDatePicker = false
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
