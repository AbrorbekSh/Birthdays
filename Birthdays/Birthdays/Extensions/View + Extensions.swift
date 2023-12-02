//
//  View + Extension.swift
//  Birthdays
//
//  Created by Аброрбек on 28.11.2023.
//

import Foundation
import SwiftUI

extension View {
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
}

extension View {
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = Rectangle(), rightToLeft: Bool = false) -> some View {
        self.overlay {
            GeometryReader { proxy in
                let size = proxy.size
                let moddedDuration = max(0.3, duration)
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .clear,
                                    .clear,
                                    .white.opacity(0.1),
                                    .white.opacity(0.5),
                                    .white.opacity(1),
                                    .white.opacity(0.5),
                                    .white.opacity(0.1),
                                    .clear,
                                    .clear,
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(y: 8)
                    .keyframeAnimator(
                        initialValue: 0.0,
                        trigger: toggle,
                        content: { content, progress in
                            content
                                .offset(x: -size.width + (progress * (size.width * 2)))
                        },
                        keyframes: { _ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: moddedDuration)
                        }
                    )
                    .rotationEffect(.init(degrees: 45))
                    .scaleEffect(x: rightToLeft ? -1 : 1)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
