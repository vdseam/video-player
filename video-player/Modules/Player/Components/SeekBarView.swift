//
//  SeekBarView.swift
//  video-player
//
//  Created by Vladyslav Deba on 16/11/2024.
//

import SwiftUI
import ComposableArchitecture
import AVKit

struct SeekBarView: View {
    let store: StoreOf<VideoPlayerFeature>
    let player: AVPlayer

    var body: some View {
        WithViewStore(store, observe: \.videoProgress) { viewStore in
            Slider(
                value: Binding(
                    get: { viewStore.state },
                    set: { newProgress in
                        let duration = player.currentItem?.duration.seconds ?? 1
                        let time = CMTime(seconds: newProgress * duration, preferredTimescale: 1)
                        player.seek(to: time)
                    }
                ),
                in: 0...1
            )
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(8)
        }
    }
}
