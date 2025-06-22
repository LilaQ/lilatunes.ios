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
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var currentSong: Song? = nil
    @Published var currentPlaylist: Playlist? = nil
    
    private init() {}
    
    func load(song: Song, playlist: Playlist? = nil) {
        
        //  store playlist, if passed
        currentPlaylist = playlist
        
        //  new song?
        if currentSong != song {
            currentTime = 0
            duration = song.duration
            playerItem = AVPlayerItem(url: song.url)
            guard let playerItem else { return }
            player = AVPlayer(playerItem: playerItem)
            currentSong = song
        }
    }
    
    func play() {
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
        currentTime = 0
        duration = 0
    }
    
    func next() {
        if let playlist = currentPlaylist,
           position_of_current_song < (playlist.songs.count - 1) {
            let next_song = playlist.songs[position_of_current_song + 1]
            load(song: next_song)
            play()
            print("next song")
        } else { print("next failed") }
    }
    
    func prev() {
        if let playlist = currentPlaylist,
           position_of_current_song > 0 {
            let prev_song = playlist.songs[position_of_current_song - 1]
            load(song: prev_song)
            play()
            print("prev song")
        } else { print("prev failed") }
    }
    
    internal var position_of_current_song: Int {
        guard let playlist = currentPlaylist,
              let song = currentSong,
              let index = playlist.songs.firstIndex(of: song) else {
            return -1
        }
        return index
    }
}
