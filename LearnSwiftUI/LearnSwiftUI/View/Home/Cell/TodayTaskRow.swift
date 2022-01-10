//
//  TodayTaskRow.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import Foundation
import SwiftUI

struct TodayTaskItem: View {
    let item: TodayTask
    var body: some View {
        Group {
            HStack {
                if item.status == 1 {
                    Image("ic_task_done")
                        .resizable()
                        .frame(width: 22, height: 22)
                } else {
                    Image("ic_check")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(item.taskType == TaskType.Business.rawValue ? Color.red : Color.blue)
                }
                if item.status != 0 {
                    Text(item.name)
                        .strikethrough()
                        .font(Font.system(size: 14))
                } else {
                    Text(item.name)
                        .font(Font.system(size: 14))
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
        }.cornerRadius(10)
    }
}
