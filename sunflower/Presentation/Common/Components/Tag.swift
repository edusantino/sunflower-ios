//
//  Tag.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 27/10/25.
//

import SwiftUI

struct Tag: View {
    var body: some View {
        HStack {
            Text("new")
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(Color.black)
                .padding(6)
        }
        .background(
            Color.white.opacity(0.8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(8)
    }
}

enum TagState {
    case new
    case dead
}

#Preview {
    Tag()
}
