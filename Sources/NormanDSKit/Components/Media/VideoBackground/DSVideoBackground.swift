//
//  DSVideoBackground.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI
import AVKit

public struct DSVideoBackground: UIViewRepresentable {
    
    private let resourceName: String
    private let fileExtension: String
    private let isMuted: Bool
    private let bundle: Bundle
    
    public init(
        resourceName: String,
        fileExtension: String = "mp4",
        isMuted: Bool = true,
        bundle: Bundle = .main
    ) {
        self.resourceName = resourceName
        self.fileExtension = fileExtension
        self.isMuted = isMuted
        self.bundle = bundle
    }

    public func makeUIView(context: Context) -> DSPlayerLayerView {
        let view = DSPlayerLayerView()
        view.backgroundColor = .clear
        
        guard let url = bundle.url(forResource: resourceName, withExtension: fileExtension) else {
            return view
        }
        
        let item = AVPlayerItem(url: url)
        let player = AVQueuePlayer()
        let looper = AVPlayerLooper(player: player, templateItem: item)
        
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        
        player.isMuted = isMuted
        player.play()
        
        // Retener referencias en el coordinador
        context.coordinator.player = player
        context.coordinator.looper = looper
        
        return view
    }

    public func updateUIView(_ uiView: DSPlayerLayerView, context: Context) {
        uiView.playerLayer.frame = uiView.bounds
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public final class Coordinator {
        var player: AVQueuePlayer?
        var looper: AVPlayerLooper?
    }
}

// UIView cuyo layer es AVPlayerLayer
public final class DSPlayerLayerView: UIView {
    public override static var layerClass: AnyClass { AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
