//
//  ContentView.swift
//  Shared
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI
import SalmonUI
import PopperUp

struct ContentView: View {
    @StateObject private var popperUpManager = PopperUpManager()

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    popperUpManager.showPopup(
                        ofType: .success,
                        title: "Successfully done something",
                        description: "such and such such",
                        timeout: nil)
                }) {
                    Text("Show alert")
                }
                Button(action: { print(Int.random(in: 0..<10)) }) {
                    Text("Randomness")
                }
            }
        }
        .ktakeSizeEagerly(alignment: .center)
        .withPopperUp(popperUpManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
