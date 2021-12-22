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
            VStack {
                Button(action: { withAnimation(.easeOut(duration: 0.5)) { alertIsShown = true } }) {
                    Text("Show alert")
                }
                Button(action: { print(Int.random(in: 0..<10)) }) {
                    Text("Randomness")
                }
            }
        }
        .ktakeSizeEagerly(alignment: .center)
        .popup(isPresented: $alertIsShown, alignment: .bottom) {
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
                    Button(action: { withAnimation(.easeIn(duration: 0.5)) { alertIsShown = false } }) {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.all, 16)
            }
            .ktakeWidthEagerly(alignment: .center)
            .background(Color(uiColor: .secondarySystemBackground))
            .padding(.bottom, 8)
            .transition(.move(edge: .bottom))
            .onAppear(perform: {
                print("appearing")
            })
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
