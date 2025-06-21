//
//  MusicPlayerService.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import Foundation
import AVFoundation
import Combine

class MusicPlayerService: ObservableObject {
    
    static let shared = MusicPlayerService() // Singleton
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    @Published var isPlaying: Bool = false
    @Published var duration: TimeInterval = 0
    @Published var currentSong: Song? = nil
    @Published var currentPlaylist: Playlist? = nil
    
    private init() {}
    
    func play(song: Song, playlist: Playlist? = nil) {
                
        //  store playlist, if passed
        currentPlaylist = playlist
        
        //  new song?
        if currentSong != song {
            guard let songUrl = song.url else { return }
            playerItem = AVPlayerItem(url: songUrl)
            guard let playerItem else { return }
            player = AVPlayer(playerItem: playerItem)
            currentSong = song
            load_duration()
        }
        player?.play()
        isPlaying = true
        
        
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func stop() {
        player?.pause()
        player = nil
        isPlaying = false
        currentSong = nil
    }
    
    func next() {
        if let playlist = currentPlaylist,
           position_of_current_song < (playlist.songs.count - 1) {
            let next_song = playlist.songs[position_of_current_song + 1]
            play(song: next_song)
        }
    }
    
    func prev() {
        if let playlist = currentPlaylist,
           position_of_current_song > 0 {
            let prev_song = playlist.songs[position_of_current_song - 1]
            play(song: prev_song)
        }
    }
    
    fileprivate var position_of_current_song: Int {
        guard let playlist = currentPlaylist,
              let song = currentSong,
              let index = playlist.songs.firstIndex(of: song) else {
            return -1
        }
        return index
    }
    
    fileprivate func load_duration() -> Void {
        guard let playerItem = playerItem else { return }
        let asset = playerItem.asset
        
        Task {
            do {
                let duration = try await asset.load(.duration)
                let seconds = CMTimeGetSeconds(duration)
                await MainActor.run {
                    self.duration = seconds
                }
            } catch {
                // Handle error, e.g. set duration to 0
                await MainActor.run {
                    self.duration = 0
                }
            }
        }
    }
}
