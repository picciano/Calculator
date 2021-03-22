//
//  Window+Key.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/21/21.
//

import SwiftUI

extension UIWindow {

    static var keyWindow: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
    }

    static var keyWindowScene: UIWindowScene? {
        keyWindow?.windowScene
    }

    static var keyWindowInterfaceOrientation: UIInterfaceOrientation? {
        UIWindow.keyWindowScene?.interfaceOrientation
    }
}
