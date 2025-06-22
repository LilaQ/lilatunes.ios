//
//  Playlist.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

struct Playlist: Codable, Equatable {
    
    var id: String
    var songs: [Song]
    var name: String
}
