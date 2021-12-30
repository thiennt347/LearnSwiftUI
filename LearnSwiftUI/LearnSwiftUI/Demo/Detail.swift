//
//  Detail.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import SwiftUI

struct Detail: View {
    let data: LearnSwiftModel
    var body: some View {
            ScrollView {
                Mapview(coordinate: data.locationCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)

                CircleImage(image: data.image)
                    .offset(y: -130)
                    .padding(.bottom, -130)

                VStack(alignment: .leading) {
                    Text(data.name)
                        .font(.title)

                    HStack {
                        Text(data.park)
                        Spacer()
                        Text(data.state)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    Divider()

                    Text("About \(data.name)")
                        .font(.title2)
                    Text(data.description)
                }
                .foregroundColor(Color.red)
                .padding()
                
                Spacer()
            }
            .navigationTitle(data.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(data: learnSwiftUIDatas[0])
    }
}
