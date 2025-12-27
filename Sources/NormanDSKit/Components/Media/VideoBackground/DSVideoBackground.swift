//
//  DSVideoBackground.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI
import AVKit
import os.log

/// A looping video background view backed by `AVPlayerLayer`.
///
/// `DSVideoBackground` renders a bundled video as a continuously looping background.
/// It uses `AVQueuePlayer` and `AVPlayerLooper` under the hood and exposes simple
/// configuration for resource name, file extension, mute state, and bundle.
///
/// ### Example
/// ```swift
/// DSVideoBackground(resourceName: "hero", fileExtension: "mp4", isMuted: true, bundle: .main)
///     .ignoresSafeArea()
/// ```
///
/// - Parameters:
///   - resourceName: The video resource name without extension.
///   - fileExtension: The file extension (e.g., "mp4"). Defaults to `"mp4"`.
///   - isMuted: Whether the playback is muted. Defaults to `true`.
///   - bundle: The bundle containing the video resource. Defaults to `.main`.
@MainActor
public struct DSVideoBackground: UIViewRepresentable {

    /// The video resource name without extension.
    private let resourceName: String
    /// The video file extension (e.g., "mp4").
    private let fileExtension: String
    /// Whether the playback is muted.
    private let isMuted: Bool
    /// The bundle containing the video resource.
    private let bundle: Bundle

    /// Creates a new `DSVideoBackground` instance.
    ///
    /// - Parameters:
    ///   - resourceName: The video resource name without extension.
    ///   - fileExtension: The file extension (e.g., "mp4"). Defaults to `"mp4"`.
    ///   - isMuted: Whether the playback is muted. Defaults to `true`.
    ///   - bundle: The bundle containing the video resource. Defaults to `.main`.
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

    /// Creates the underlying `DSPlayerLayerView` and configures the player if needed.
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

    /// Updates the player configuration when inputs change and ensures the layer fits bounds.
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

    /// Stops playback and tears down player resources when the view is removed.
    public static func dismantleUIView(_ uiView: DSPlayerLayerView, coordinator: Coordinator) {
        coordinator.stopAndTearDown(on: uiView)
    }

    /// Creates a coordinator responsible for managing the player and looper.
    public func makeCoordinator() -> Coordinator { Coordinator() }

    /// Coordinates `AVQueuePlayer` and `AVPlayerLooper` lifecycle for the background view.
    @MainActor
    public final class Coordinator {
        private var player: AVQueuePlayer?
        private var looper: AVPlayerLooper?
        private var currentKey: String?

        private let log = Logger(subsystem: "NormanDSKit", category: "DSVideoBackground")

        /// Configures the player on a given view if not already configured for the current resource.
        func configureIfNeeded(
            on view: DSPlayerLayerView,
            resourceName: String,
            fileExtension: String,
            isMuted: Bool,
            bundle: Bundle
        ) {
            update(on: view, resourceName: resourceName, fileExtension: fileExtension, isMuted: isMuted, bundle: bundle)
        }

        /// Updates or reconfigures the player when the resource key changes or mute state updates.
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

        /// Stops playback and releases player and looper.
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

/// A `UIView` whose backing layer is `AVPlayerLayer` used by `DSVideoBackground`.
public final class DSPlayerLayerView: UIView {
    /// Uses `AVPlayerLayer` as the backing layer class.
    public override static var layerClass: AnyClass { AVPlayerLayer.self }
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }

    /// Ensures the player layer always fills the view's bounds.
    public override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

