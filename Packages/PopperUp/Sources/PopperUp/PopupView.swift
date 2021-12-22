//
//  PopupView.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI
import SalmonUI

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
        .background(manager.config.backgroundColor)
        .padding(.bottom, 8)
        .transition(.move(edge: .bottom))
    }
}

@available(iOS 15.0, *)
struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(manager: .init(config: .init(backgroundColor: .init(uiColor: .secondarySystemBackground))))
    }
}
