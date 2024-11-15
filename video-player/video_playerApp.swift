//
//  video_playerApp.swift
//  video-player
//
//  Created by Vladyslav Deba on 14/11/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct video_playerApp: App {
    var body: some Scene {
        WindowGroup {
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
    }
}
