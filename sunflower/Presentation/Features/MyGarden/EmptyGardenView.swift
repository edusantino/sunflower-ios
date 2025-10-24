//
//  EmptyGardenView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

struct EmptyGardenView: View {
    let onAddClick: () -> Void
    
    // MARK: - Constants
    private enum Constants {
        static let titleFontSize: CGFloat = 25
        static let buttonFontSize: CGFloat = 14
        static let buttonWidth: CGFloat = 120
        static let buttonHeight: CGFloat = 44
        static let cornerRadius: CGFloat = 8
    }
    
    var body: some View {
        VStack {
            Text("Your garden is empty")
                .font(.system(size: Constants.titleFontSize))
                .foregroundColor(.white)
            
            addButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(DesignSystem.Colors.background))
        .onAppear {
            print("Empty Garden Showing")
        }
    }
}

extension EmptyGardenView {
    private var addButton: some View {
        Button {
            onAddClick()
        } label: {
            HStack {
                Text("Add plant")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
            }
            .frame(width: 80, height: 10)
            .padding()
            .background(Color(DesignSystem.Colors.secondaryColor))
            .cornerRadius(8, corners: [.topRight, .bottomLeft])
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0)
                    .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomLeft]))
            )
        }
    }
}

#Preview {
    EmptyGardenView(onAddClick: {})
}
