//
//  DesignSystem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 13/10/25.
//

import Foundation
import SwiftUI

enum DesignSystem {
    enum Colors {
        static let background = Color(red: 26/255, green: 28/255, blue: 24/255)
        static let primaryText = Color.white
        static let tabColor = Color.green
        static let tabInactive = Color.gray
    }
    
    enum Fonts {
        static let title = Font.system(size: 32, weight: .bold)
        static let tabTitle = Font.system(size: 16, weight: .semibold)
        static let icon = Font.system(size: 24)
    }
    
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 20
        static let topSafeArea: CGFloat = 10
    }
    
}
