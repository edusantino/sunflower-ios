//
//  AddButton.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 04/10/25.
//

import SwiftUI

struct AddButton: View {
    @State private var isAdded: Bool
    let onTap: () -> Void
    
    init(isAdded: Bool = false, onTap: @escaping () -> Void) {
        self._isAdded = State(initialValue: isAdded)
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: {
            isAdded.toggle()
            onTap()
        }) {
            Image(systemName: isAdded ? "checkmark" : "plus")
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .medium))
                .scaleEffect(isAdded ? 0.8 : 1.0)
        }
        .frame(width: 60, height: 60)
        .background(isAdded ? Color.green : Color(red: 42/255, green: 81/255, blue: 18/255))
        .cornerRadius(8, corners: [.topRight, .bottomLeft])
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0)
                .clipShape(
                    RoundedCorner(
                        radius: 8, corners: [.topRight, .bottomLeft]
                    )
                )
        )
        .padding(.trailing, 20)
        .offset(x: -1, y: 30)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isAdded)
    }
}

#Preview {
    AddButton(isAdded: false, onTap: {})
}
