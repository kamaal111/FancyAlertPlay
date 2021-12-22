//
//  PopperUpManager.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

public final class PopperUpManager: ObservableObject {

    @Published var isShown = false

    public init() { }

    public func showPopup() {
        withAnimation(.easeOut(duration: 0.5)) { isShown = true }
    }

    public func hidePopup() {
        withAnimation(.easeIn(duration: 0.5)) { isShown = false }
    }

}
