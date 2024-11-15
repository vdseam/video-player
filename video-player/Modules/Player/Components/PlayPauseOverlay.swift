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

    var body: some View {
        VStack {
            Spacer()
            if showControls {
                Button(action: {
                    onPlayPauseTapped()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .transition(.opacity)
            }
            Spacer()
        }
        .onTapGesture {
            onShowControls()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onHideControls()
            }
        }
    }
}
