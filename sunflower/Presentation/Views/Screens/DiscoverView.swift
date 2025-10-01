//
//  DiscoverView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(0..<12) { _ in
                    DiscoverItem()
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

#Preview {
    DiscoverView()
}
