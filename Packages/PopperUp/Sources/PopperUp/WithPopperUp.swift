//
//  WithPopperUp.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI
import SalmonUI

extension View {
    public func withPopperUp(@ObservedObject _ manager: PopperUpManager) -> some View {
        self
            .popup(isPresented: $manager.isShown, alignment: .bottom, content: {
                PopupView(manager: manager)
            })
            .environmentObject(manager)
    }

    private func popup<Content: View>(
        isPresented: Binding<Bool>,
        alignment: Alignment,
        @ViewBuilder content: () -> Content) -> some View {
            self
                .modifier(Popup(isPresented: isPresented, alignment: alignment, content: content))
        }
}

struct Popup<V: View>: ViewModifier {
    @Binding var isPresented: Bool

    let alignment: Alignment
    let popup: V

    init(isPresented: Binding<Bool>, alignment: Alignment, @ViewBuilder content: () -> V) {
        self._isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader(content: { geometry in
                if isPresented {
                    popup
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                }
            }))
    }
}
