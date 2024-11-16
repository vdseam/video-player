//
//  PlayPauseOverlay.swift
//  video-player
//
//  Created by Vladyslav Deba on 16/11/2024.
//

import SwiftUI

struct PlayPauseOverlay: View {
    let isPlaying: Bool
    let showControls: Bool
    let onPlayPauseTapped: () -> Void
    let onShowControls: () -> Void
    let onHideControls: () -> Void

    @State private var isVisible = true
    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            Spacer()
            if isVisible {
                Button {
                    onPlayPauseTapped()
                    resetTimer()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .contentShape(.rect)
        .onTapGesture {
            if isVisible {
                setVisible(false)
                onHideControls()
            } else {
                onShowControls()
                resetTimer()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            setVisible(false)
            onHideControls()
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        setVisible(true)
        startTimer()
    }
    
    private func setVisible(_ visible: Bool) {
        withAnimation(.easeOut(duration: 0.12)) {
            isVisible = visible
        }
    }
}
