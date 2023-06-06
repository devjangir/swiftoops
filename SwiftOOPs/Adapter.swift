//
//  Adapter.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 06/06/23.
//

import Foundation

// Media Player Interface
protocol MediaPlayer {
    func playAudio(fileName: String)
}

// Video Player Interface
protocol VideoPlayer {
    func playVideo(fileName: String)
}

class AudioPlayer: MediaPlayer {
    func playAudio(fileName: String) {
        print("Playing audio file \(fileName)")
    }
}

class VideoPlayerAdapter: MediaPlayer {
    private let videoPlayer: VideoPlayer
    init(videoPlayer: VideoPlayer) {
        self.videoPlayer = videoPlayer
    }
    
    func playAudio(fileName: String) {
        videoPlayer.playVideo(fileName: fileName)
    }
}

class DefaultVideoPlayer: VideoPlayer {
    func playVideo(fileName: String) {
        print("Playing video file \(fileName)")
    }
}

func testAdapter() {
    let audioPlayer = AudioPlayer()
    let videoPlayer = DefaultVideoPlayer()
    let videoAdapter = VideoPlayerAdapter(videoPlayer: videoPlayer)
    videoAdapter.playAudio(fileName: "movie.mp4")
    audioPlayer.playAudio(fileName: "song.mp3")
}
