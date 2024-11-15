//
//  VideoPlayerFeature.swift
//  video-player
//
//  Created by Vladyslav Deba on 16/11/2024.
//

import ComposableArchitecture
import Foundation

struct VideoPlayerFeature: Reducer {
    struct State: Equatable {
        var isPlaying = false
        var showControls = true
        var videoProgress: Double = 0
    }

    enum Action: Equatable {
        case playPauseTapped
        case updateProgress(Double)
        case showControls
        case hideControls
        case videoEnded
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .playPauseTapped:
            state.isPlaying.toggle()
            
        case .updateProgress(let progress):
            state.videoProgress = progress
            
        case .showControls:
            state.showControls = true
            
        case .hideControls:
            state.showControls = false
            
        case .videoEnded:
            state.isPlaying = false
        }
        return .none
    }
}
