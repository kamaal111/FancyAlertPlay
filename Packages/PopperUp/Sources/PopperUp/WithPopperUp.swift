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

struct PopupView: View {
    @ObservedObject var manager: PopperUpManager

    var body: some View {
        KJustStack {
            HStack(alignment: .top) {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(.red)
                VStack(alignment: .leading) {
                    Text("OMG something critical happened!")
                        .foregroundColor(.red)
                        .bold()
                    Text("Well everything just broke down, what now?\nLets go with another line")
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: { manager.hidePopup() }) {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundColor(.secondary)
                }
            }
            .padding(.all, 16)
        }
        .ktakeWidthEagerly(alignment: .center)
//        .background(Color(uiColor: .secondarySystemBackground))
        .padding(.bottom, 8)
        .transition(.move(edge: .bottom))
        .onAppear(perform: {
            print("appearing")
        })
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
