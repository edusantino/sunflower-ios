//
//  EmptyGardenView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

struct EmptyGardenView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    
    let onAddClick: () -> Void
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            } else if viewModel.myGardenPlants.isEmpty {
                Text("Your garden is empty")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                
                AddButton()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(DesignSystem.Colors.background))
        .onAppear {
            print("Empty Garden Showing")
        }
        .onChange(of: viewModel.state) { isLoading in
            
        }
    }
}

extension EmptyGardenView {
    private func AddButton() -> some View {
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
