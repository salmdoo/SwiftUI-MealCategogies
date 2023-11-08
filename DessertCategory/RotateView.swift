//
//  RotateView.swift
//  DessertCategory
//
//  Created by Salmdo on 11/8/23.
//

import SwiftUI

struct DetectOrientationViewModifier: ViewModifier {
    let listenOnRotate: Bool
    let action: (UIDeviceOrientation) -> Void

    
    func body(content: Content) -> some View {
        if listenOnRotate {
            content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
        } else {
            content
        }
    }
}

extension View {
    func onRotate(listenOnRotate: Bool = false, perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DetectOrientationViewModifier(listenOnRotate:listenOnRotate, action: action))
    }
}
