//
//  AddButton.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 04/10/25.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .foregroundColor(Color.white)
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
        .padding(.trailing, 20)
        .offset(x: -1, y: 30)
    }
}
