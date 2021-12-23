//
//  FancyAlertPlayApp.swift
//  Shared
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

@main
struct FancyAlertPlayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                #if os(macOS)
                .frame(minWidth: 300, minHeight: 300)
                #endif
        }
    }
}
