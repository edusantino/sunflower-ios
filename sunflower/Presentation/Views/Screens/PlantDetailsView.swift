//
//  PlantDetailsView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 29/09/25.
//

import SwiftUI
import Foundation

struct PlantDetailsView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image("avocado")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity,
                           maxHeight: 300)
                    .clipped()
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.yellow)
                }
                .frame(width: 60, height: 60)
                .background(Color(red: 42/255, green: 81/255, blue: 18/255)) // Button color
                .cornerRadius(8, corners: [.topRight, .bottomLeft])
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 8)
                    .stroke(Color.gray, lineWidth:
                                0)
                    .clipShape(
                        RoundedCorner(
                            radius: 8, corners: [.topRight, .bottomLeft]
                        )
                    )
                )
                .padding(.trailing, 80)
                .offset(x: -20, y: 30)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 26/255, green: 28/255, blue: 24/255)) // Background color
        .ignoresSafeArea()
    }
}

#Preview {
    PlantDetailsView()
}
