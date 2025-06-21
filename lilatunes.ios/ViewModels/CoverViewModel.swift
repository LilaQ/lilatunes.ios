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
    private let cancellables = Set<AnyCancellable>()
    
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
        self.song = song
        
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
            musicPlayerService.play(song: song)
        }
        
        //  pause
        else {
            musicPlayerService.pause()
        }
    }
    
    static func demo() -> CoverViewModel {
        let demo = CoverViewModel(song: Song.demo)
        demo.currentTime = demo.song.duration * 0.4
        return demo
    }
}
