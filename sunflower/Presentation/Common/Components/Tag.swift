//
//  Tag.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 27/10/25.
//

import SwiftUI

struct Tag: View {
    let status: TagStatus
    let size: TagSize
    
    init(status: TagStatus, size: TagSize = .small) {
        self.status = status
        self.size = size
    }
    
    private var configuration: TagConfiguration {
        switch status {
        case .new:
            return TagConfiguration(
                text: "New",
                backgroundColor: .green.opacity(0.9),
                textColor: .white,
                icon: "leaf"
            )
        case .dead:
            return TagConfiguration(
                text: "Dead",
                backgroundColor: .red.opacity(0.9),
                textColor: .white,
                icon: "xmark.circle"
            )
        case .needWatering:
            return TagConfiguration(
                text: "Needed",
                backgroundColor: .orange.opacity(0.9),
                textColor: .white,
                icon: "drop"
            )
        }
    }
    
    private var padding: EdgeInsets {
        switch size {
        case .small:
            return EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        case .medium:
            return EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        case .large:
            return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        }
    }
    
    private var fontSize: CGFloat {
        switch size {
        case .small: return 10
        case .medium: return 12
        case .large: return 14
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            if let iconName = configuration.icon {
                Image(systemName: iconName)
                    .font(.system(size: fontSize - 2, weight: .semibold))
            }
            
            Text(configuration.text)
                .font(.system(size: fontSize, weight: .semibold))
        }
        .foregroundColor(configuration.textColor)
        .padding(padding)
        .background(configuration.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(configuration.backgroundColor.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Supporting Types

enum TagStatus {
    case new, dead, needWatering, regular
}

enum TagSize {
    case small, medium, large
}

struct TagConfiguration {
    let text: String
    let backgroundColor: Color
    let textColor: Color
    let icon: String?
    
    init(text: String, backgroundColor: Color, textColor: Color, icon: String? = nil) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.icon = icon
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        Tag(status: .new)
        Tag(status: .dead)
        Tag(status: .needWatering)
        
        Divider()
        
        Tag(status: .new, size: .small)
        Tag(status: .dead, size: .small)
        Tag(status: .needWatering, size: .small)
        
        Tag(status: .new, size: .large)
        Tag(status: .dead, size: .large)
        Tag(status: .needWatering, size: .large)
    }
    .padding()
}
