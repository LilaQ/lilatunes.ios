//
//  ToastManager.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 22.06.25.
//

import SwiftUI
import Combine

class ToastManager: ObservableObject {
    static let shared = ToastManager()

    @Published var message: String = ""
    @Published var isShowing: Bool = false

    private var queue: [String] = []
    private var isProcessing = false
    private let defaultDuration: TimeInterval = 2.0

    func show(_ message: String, duration: TimeInterval = 2.0) {
        DispatchQueue.main.async {
            self.queue.append(message)
            self.processQueue(duration: duration)
        }
    }

    private func processQueue(duration: TimeInterval) {
        guard !isProcessing, !queue.isEmpty else { return }
        isProcessing = true
        let nextMessage = queue.removeFirst()
        self.message = nextMessage
        withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.7)) {
            self.isShowing = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isShowing = false
            }
            // Wait for the animation to finish before showing next
            let animationDuration: TimeInterval = 0.5 // Adjust based on your out-animation
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.isProcessing = false
                self.processQueue(duration: duration)
            }
        }
    }
}

struct ToastModifier: ViewModifier {
    @ObservedObject var toastManager: ToastManager

    func body(content: Content) -> some View {
        content
            .overlay {
                if toastManager.isShowing {
                    VStack {
                        Spacer()
                        Text(toastManager.message)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
                        Spacer()
                    }
                    .id(UUID().uuidString)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        )
                    )
                }
            }
    }
}

extension View {
    func toastOverlay(using toastManager: ToastManager) -> some View {
        self.modifier(ToastModifier(toastManager: toastManager))
    }
}
