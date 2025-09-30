//
//  MyGardenItem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

struct MyGardenItem: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("avocado")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 80)
                .clipped()
                .cornerRadius(8, corners: [.topRight])
            
            VStack {
                Text("Apple")
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                
                Text("Planted")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                Text("Sep 28, 2025")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                    .padding(.bottom, 5)
                
                Text("Last Watered")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                Text("Sep 28, 2025")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                Text("water in 30 days.")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
                    .padding(.bottom, 15)
            }
            .background(Color(red: 64/255, green: 74/255, blue: 56/255))
            .cornerRadius(8, corners: [.bottomLeft])
        }
        .frame(width: 140, height: 220)
        .background(Color.white)
        .cornerRadius(8, corners: [.topRight, .bottomLeft])
    }
}
#Preview {
    MyGardenItem()
}
