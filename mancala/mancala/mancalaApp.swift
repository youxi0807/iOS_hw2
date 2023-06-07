//
//  mancalaApp.swift
//  mancala
//
//  Created by User03 on 2023/6/8.
//

import SwiftUI
import AVFoundation

@main
struct MancalaApp: App {
  init() {
    AVPlayer.setupBgMusic()
    AVPlayer.bgQueuePlayer.play()
  }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
