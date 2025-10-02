//
//  MyGardenView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct MyGardenView: View {
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(0..<6) { _ in
                    MyGardenItem()
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

#Preview {
    MyGardenView()
}
