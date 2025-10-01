//
//  DiscoverItem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

struct DiscoverItem: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("avocado")
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 100)
                .clipped()
            
            Text("Apple")
                .frame(maxWidth: .infinity, minHeight: 50)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                .background(Color(red: 64/255, green: 74/255, blue: 56/255))
        }
        .frame(width: 180, height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0)
        )
        .cornerRadius(8, corners: [.topRight, .bottomLeft])
    }
}

#Preview {
    DiscoverItem()
}
