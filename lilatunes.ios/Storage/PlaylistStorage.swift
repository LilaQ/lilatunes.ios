//
//  PlaylistStorage.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 22.06.25.
//

import Foundation

class PlaylistStorage {
    private let filename: String
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
    }
    
    static let favorites = PlaylistStorage(playlist_id: "favorites")
    
    init(playlist_id: String) {
        self.filename = "\(playlist_id).json"
    }
    
    func save(songs: [Song]) throws {
        let data = try JSONEncoder().encode(songs)
        try data.write(to: fileURL, options: [.atomic])
    }
    
    func load() throws -> [Song] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Song].self, from: data)
    }
    
    func add(song: Song) throws {
        var songs = try load()
        if !songs.contains(song) {
            songs.append(song)
            try save(songs: songs)
        }
    }
    
    func remove(song: Song) throws {
        var songs = try load()
        if let index = songs.firstIndex(of: song) {
            songs.remove(at: index)
            try save(songs: songs)
        }
    }
    
    func contains(song: Song) throws -> Bool {
        let songs = try load()
        return songs.contains(song)
    }
}
