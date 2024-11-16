//
//  VideoPlayerView.swift
//  video-player
//
//  Created by Vladyslav Deba on 15/11/2024.
//

import SwiftUI
import AVKit
import ComposableArchitecture

struct VideoPlayerView: View {
    let store: StoreOf<VideoPlayerFeature>
    private let player = AVPlayer(
        url: Bundle.main.url(
            forResource: "4678261-hd_1080_1920_25fps",
            withExtension: "mp4"
        )!
    )
    private let textLayer = CATextLayer()

    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            ZStack {
                VideoPlayerRepresentable(player: player, textLayer: textLayer)

                VStack {
                    Spacer()
                    
                    PlayPauseOverlay(
                        isPlaying: viewStore.isPlaying,
                        showControls: viewStore.showControls,
                        onPlayPauseTapped: {
                            viewStore.send(.playPauseTapped)
                            viewStore.isPlaying ? player.play() : player.pause()
                        },
                        onShowControls: { viewStore.send(.showControls) },
                        onHideControls: { viewStore.send(.hideControls) }
                    )
                    
                    SeekBarView(store: store, player: player)
                        .padding(16)
                }
            }
            .onAppear {
                addLoopingBehavior()
                addPeriodicTimeObserver(viewStore: viewStore)
                setupTextLayer()
            }
        }
    }
    
    private func addLoopingBehavior() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }

    private func addPeriodicTimeObserver(viewStore: ViewStore<VideoPlayerFeature.State, VideoPlayerFeature.Action>) {
        player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 600),
            queue: .main
        ) { time in
            let progress = time.seconds / (player.currentItem?.duration.seconds ?? 1)
            viewStore.send(.updateProgress(progress))

            let isWithinRange = progress >= 0.3 && progress <= 0.5
            textLayer.isHidden = !isWithinRange
        }
    }

    private func setupTextLayer() {
        textLayer.string = "Verba"
        textLayer.fontSize = 36
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        textLayer.cornerRadius = 8
        textLayer.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        textLayer.isHidden = true
    }
}

#Preview {
    VideoPlayerView(
        store: Store(
            initialState: VideoPlayerFeature.State(),
            reducer: {
                VideoPlayerFeature()
                    ._printChanges()
            }
        )
    )
}
