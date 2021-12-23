//
//  PopperUpTypes.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import Foundation
import SwiftUI

public enum PopperUpTypes {
    case success
    case warning
    case error

    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "x.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .success: return .green
        case .warning: return .yellow
        case .error: return .red
        }
    }
}
