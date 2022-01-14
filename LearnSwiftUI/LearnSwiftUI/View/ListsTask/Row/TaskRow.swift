//
//  TaskRow.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/14/22.
//

import SwiftUI

struct TaskRow: View {
    var data: TaskDB
    var title: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if data.isComplete {
                    Text(data.taskName ?? "")
                        .strikethrough()
                        .font(Font.system(size: 16))
                        .foregroundColor(.blue)
                } else {
                    Text(data.taskName ?? "")
                        .font(Font.system(size: 16, weight: .regular))
                }
                
                Text(data.taskDate?.dateToString(dateFormat: "HH:mm") ?? "")
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundColor(title == "Late" ? Color.red : .gray)
            }
            .hLeading()
            
            Image(systemName: data.isComplete ? "checkmark.square.fill" : "square")
                .foregroundColor(data.isComplete ? Color(UIColor.systemBlue) : Color.gray)
                .font(Font.system(size: 24))
                .onTapGesture {
                    if title == "Done" {
                        return
                    }
                    data.isComplete.toggle()
                }
        }
        .opacity(title == "Done" ? 0.5 : 1)
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

struct ListTaskSection: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.system(size: 14))
                .foregroundColor(.gray)
        }
        .opacity(title == "Done" ? 0.5 : 1)
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}


