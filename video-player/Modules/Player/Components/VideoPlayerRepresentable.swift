//
//  VideoPlayerRepresentable.swift
//  video-player
//
//  Created by Vladyslav Deba on 16/11/2024.
//

import SwiftUI
import AVKit

struct VideoPlayerRepresentable: UIViewControllerRepresentable {
    let player: AVPlayer
    let textLayer: CATextLayer

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = viewController.view.bounds
        viewController.view.layer.addSublayer(playerLayer)
        viewController.view.layer.addSublayer(textLayer)

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
