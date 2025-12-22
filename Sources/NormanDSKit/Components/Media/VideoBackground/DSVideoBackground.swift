//
//  DSVideoBackground.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI
import AVKit
import os.log

@MainActor
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
        context.coordinator.configureIfNeeded(
            on: view,
            resourceName: resourceName,
            fileExtension: fileExtension,
            isMuted: isMuted,
            bundle: bundle
        )
        return view
    }

    public func updateUIView(_ uiView: DSPlayerLayerView, context: Context) {
        uiView.playerLayer.frame = uiView.bounds

        context.coordinator.update(
            on: uiView,
            resourceName: resourceName,
            fileExtension: fileExtension,
            isMuted: isMuted,
            bundle: bundle
        )
    }

    public static func dismantleUIView(_ uiView: DSPlayerLayerView, coordinator: Coordinator) {
        coordinator.stopAndTearDown(on: uiView)
    }

    public func makeCoordinator() -> Coordinator { Coordinator() }

    @MainActor
    public final class Coordinator {
        private var player: AVQueuePlayer?
        private var looper: AVPlayerLooper?
        private var currentKey: String?

        private let log = Logger(subsystem: "NormanDSKit", category: "DSVideoBackground")

        func configureIfNeeded(
            on view: DSPlayerLayerView,
            resourceName: String,
            fileExtension: String,
            isMuted: Bool,
            bundle: Bundle
        ) {
            update(on: view, resourceName: resourceName, fileExtension: fileExtension, isMuted: isMuted, bundle: bundle)
        }

        func update(
            on view: DSPlayerLayerView,
            resourceName: String,
            fileExtension: String,
            isMuted: Bool,
            bundle: Bundle
        ) {
            let key = "\(bundle.bundleIdentifier ?? "bundle")|\(resourceName).\(fileExtension)"

            if currentKey != key {
                stopAndTearDown(on: view)

                guard let url = bundle.url(forResource: resourceName, withExtension: fileExtension) else {
                    log.error("Video resource not found: \(resourceName).\(fileExtension), bundle: \(bundle.bundleURL.absoluteString, privacy: .public)")
                    return
                }

                let item = AVPlayerItem(url: url)
                let player = AVQueuePlayer()
                let looper = AVPlayerLooper(player: player, templateItem: item)

                view.playerLayer.player = player
                view.playerLayer.videoGravity = .resizeAspectFill

                player.isMuted = isMuted
                player.play()

                self.player = player
                self.looper = looper
                self.currentKey = key
            } else {
                player?.isMuted = isMuted
            }
        }

        func stopAndTearDown(on view: DSPlayerLayerView) {
            player?.pause()
            player?.removeAllItems()
            view.playerLayer.player = nil

            looper = nil
            player = nil
            currentKey = nil
        }
    }
}

public final class DSPlayerLayerView: UIView {
    public override static var layerClass: AnyClass { AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }

    public override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

