//
//  CoverViewModel.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

import Foundation
import Combine

class CoverViewModel: ObservableObject {
    
    @Published var isPlaying: Bool = false
    @Published var isFavorite: Bool = false
    @Published var isShuffled: Bool = false
    @Published var isLooped: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    
    let song: Song
    private let musicPlayerService: MusicPlayerService = .shared
    
    var artistName: String {
        return song.artist
    }
    
    var songName: String {
        return song.title
    }
    
    var coverImageUrl: URL? {
        return song.coverUrl
    }
    
    init(song: Song) {
        print("CoverViewModel init")
        
        self.song = song
        
        currentTime = 0
        
        self.isFavorite = (try? PlaylistStorage.favorites.contains(song: song)) ?? false
        
        self.musicPlayerService.load(song: song)
        
        //  chain the published var of the service to the viewmodels published var,
        //  so the UI can access it directly and only from its viewmodel
        self.musicPlayerService.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: &$isPlaying)
        
        self.musicPlayerService.$duration
            .receive(on: RunLoop.main)
            .assign(to: &$duration)
    }
    
    func prevSong() {
        
    }
    
    func nextSong() {
        
    }
    
    func playPause() {
       
        //  play
        if !isPlaying {
            musicPlayerService.play()
        }
        
        //  pause
        else {
            musicPlayerService.pause()
        }
    }
    
    func toggleFavorite() {
        self.isFavorite.toggle()
        
        do {
            self.isFavorite ?   try PlaylistStorage.favorites.add(song: song) :
                                try PlaylistStorage.favorites.remove(song: song)
        } catch {
            self.isFavorite.toggle()
        }
    }
    
    static func demo() -> CoverViewModel {
        let demo = CoverViewModel(song: Song.demo)
        demo.currentTime = demo.song.duration * 0.4
        return demo
    }
}
