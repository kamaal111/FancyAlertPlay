//
//  PopperUpTypes.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import Foundation

public enum PopperUpTypes {
    case success
    case warning
    case error

    var iconName: String {
        switch self {
        case .success:
             return ""
        case .warning:
            return ""
        case .error:
            return "x.circle.fill"
        }
    }
}
