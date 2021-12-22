//
//  PopperUpManager.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

public final class PopperUpManager: ObservableObject {

    @Published var isShown = false
    @Published private(set) var config: PopperUpConfig
    @Published private(set) var lastTimeout: TimeInterval? {
        didSet { lastTimeoutDidSet() }
    }

    public init(config: PopperUpConfig) {
        self.config = config
    }

    public func showPopup(timeout: TimeInterval? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            withAnimation(.easeOut(duration: 0.5)) { self.isShown = true }
            self.lastTimeout = timeout
        }
    }

    public func hidePopup() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            withAnimation(.easeIn(duration: 0.5)) { self.isShown = false }
            self.lastTimeout = nil
        }
    }

    public func setConfig(with config: PopperUpConfig) {
        self.config = config
    }

    private func lastTimeoutDidSet() {
        guard let lastTimeout = self.lastTimeout else { return }
        Timer.scheduledTimer(
            timeInterval: lastTimeout,
            target: self,
            selector: #selector(handleTimeout),
            userInfo: nil,
            repeats: false)
    }

    @objc
    private func handleTimeout(_ sender: Timer?) {
        sender?.invalidate()
        hidePopup()
    }

}
