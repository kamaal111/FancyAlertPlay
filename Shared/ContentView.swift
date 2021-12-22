//
//  ContentView.swift
//  Shared
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI
import SalmonUI

struct ContentView: View {
    @State private var alertIsShown = false

    var body: some View {
        ZStack {
            Color.pink
            VStack {
                Button(action: { alertIsShown = true }) {
                    Text("Show alert")
                }
                Button(action: { print(Int.random(in: 0..<10)) }) {
                    Text("Randomness")
                }
            }
        }
        .popup(isPresented: $alertIsShown, alignment: .bottom) {
            VStack {
                Text("WARNING")
            }
            .ktakeWidthEagerly(alignment: .center)
            .background(.yellow)
            .padding(.bottom, 8)
        }
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

extension View {
    func popup<Content: View>(
        isPresented: Binding<Bool>,
        alignment: Alignment,
        @ViewBuilder content: () -> Content) -> some View {
            self
                .modifier(Popup(isPresented: isPresented, alignment: alignment, content: content))
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
