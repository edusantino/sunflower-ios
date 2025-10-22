//
//  SplashView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 22/10/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image(systemName: "leaf.fill") // Note o "systemName" aqui
                .font(.system(size: 80))
                .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
