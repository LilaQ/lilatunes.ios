//
//  SpringyButton.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUI

struct SpringyButton<Content: View>: View {
    let action: () -> Void
    let content: () -> Content
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Button(action: {
            action()
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                scale = 1.2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    scale = 1.0
                }
            }
        }) {
            content()
                .scaleEffect(scale)
        }
    }
}
