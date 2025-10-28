//
//  AddButton.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 04/10/25.
//

import SwiftUI

struct AddButton: View {
    let state: ButtonState
    let action: () -> Void
    
    enum ButtonState {
        case enabled
        case loading
        case completed
        case disabled
    }
    
    var body: some View {
        Button(action: action) {
            buttonContent
        }
        .disabled(!state.isEnabled)
        .buttonStyle(AddButtonStyle(state: state))
    }
    
    @ViewBuilder
    private var buttonContent: some View {
        switch state {
        case .enabled, .disabled:
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        case .completed:
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
                .scaleEffect(0.8)
        }
    }
}

// MARK: - Button Style
struct AddButtonStyle: ButtonStyle {
    let state: AddButton.ButtonState
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 60, height: 60)
            .background(backgroundColor)
            .cornerRadius(8, corners: [.topRight, .bottomLeft])
            .overlay(overlay)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: state)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
    
    private var backgroundColor: Color {
        switch state {
        case .enabled: return Color(red: 42/255, green: 81/255, blue: 18/255)
        case .loading: return Color(red: 42/255, green: 81/255, blue: 18/255).opacity(0.8)
        case .completed: return .green
        case .disabled: return .gray
        }
    }
    
    private var overlay: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 0)
            .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomLeft]))
    }
}

// MARK: - State Extensions
extension AddButton.ButtonState {
    var isEnabled: Bool {
        switch self {
        case .enabled: return true
        case .loading, .completed, .disabled: return false
        }
    }
}

#Preview {
    AddButton(state: .loading, action: {})
}
