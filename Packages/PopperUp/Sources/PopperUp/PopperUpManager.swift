//
//  PopperUpManager.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

public final class PopperUpManager: ObservableObject {

    @Published var isShown = false
    @Published var popupTitle = ""
    @Published var popupDescription: String?
    @Published private(set) var popperUpType: PopperUpTypes = .success
    @Published private(set) var config: PopperUpConfig
    @Published private var lastTimeout: TimeInterval? {
        didSet { lastTimeoutDidSet() }
    }

    private var timeoutTimer: Timer?

    public init(config: PopperUpConfig = .init()) {
        self.config = config
    }

    public func showPopup(
        ofType type: PopperUpTypes,
        title: String,
        description: String? = nil, timeout: TimeInterval? = nil) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.popperUpType = type
                self.popupTitle = title
                self.popupDescription = description
                withAnimation(.easeOut(duration: 0.5)) { self.isShown = true }
                self.lastTimeout = timeout
            }
        }

    public func hidePopup() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            withAnimation(.easeIn(duration: 0.8)) { self.isShown = false }
            self.lastTimeout = nil
            self.timeoutTimer?.invalidate()
        }
    }

    public func setConfig(with config: PopperUpConfig) {
        self.config = config
    }

    private func lastTimeoutDidSet() {
        guard let lastTimeout = self.lastTimeout else { return }
        let timeoutTimer = Timer.scheduledTimer(
            timeInterval: lastTimeout,
            target: self,
            selector: #selector(handleTimeout),
            userInfo: nil,
            repeats: false)
        self.timeoutTimer = timeoutTimer
    }

    @objc
    private func handleTimeout(_ sender: Timer?) {
        timeoutTimer?.invalidate()
        hidePopup()
    }

}
