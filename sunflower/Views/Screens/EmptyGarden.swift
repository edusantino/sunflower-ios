//
//  EmptyGarden.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

import SwiftUI

// Extensão mantida
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct EmptyGarden: View {
    var body: some View {
        VStack {
            Text("Your garden is empty")
                .font(.system(size: 25))
                .foregroundColor(.white) // Adicionei cor para o texto
            
            Button {
                // ação aqui
            } label: {
                HStack {
                    Text("Add plant")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black)
                }
                .frame(width: 80, height: 10)
                .padding()
                .background(Color(red: 157/255, green: 216/255, blue: 117/255)) // Cor de fundo do botão
                .cornerRadius(8, corners: [.topRight, .bottomLeft])
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0)
                        .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomLeft]))
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 26/255, green: 28/255, blue: 24/255)) // Cor de fundo da tela
    }
}

#Preview {
    EmptyGarden()
}
