//
//  TabButton.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: DesignSystem.Spacing.small) {
                Image(systemName: iconName)
                    .font(DesignSystem.Fonts.icon)
                    .foregroundColor(isSelected ? DesignSystem.Colors.tabActive : DesignSystem.Colors.tabInactive)
                
                Text(title)
                    .font(DesignSystem.Fonts.tabTitle)
                    .foregroundColor(isSelected ? DesignSystem.Colors.tabActive : DesignSystem.Colors.tabInactive)
                
                Rectangle()
                    .fill(isSelected ? DesignSystem.Colors.tabColor : Color.clear)
                    .frame(height: 2)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title) tab")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    let tabs = ContentViewModel.Tab.allCases
    return HStack(spacing: 0) {
        ForEach(tabs) { tab in
            TabButton(
                title: tab.title,
                isSelected: tab == .myGarden,
                iconName: tab.iconName,
                action: {}
            )
        }
    }
    .padding(.horizontal, DesignSystem.Spacing.large)
    .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
    .background(DesignSystem.Colors.background)
}
