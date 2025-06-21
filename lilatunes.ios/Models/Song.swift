//
//  Song.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

import Foundation

struct Song: Codable, Equatable {
    let id: Int
    let title: String
    let artist: String
    let album: String
    let duration: TimeInterval
    let url: URL?
    let coverUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artist
        case album
        case duration
        case url
        case coverUrl
    }
    
    init(
        id: Int,
        title: String,
        artist: String,
        album: String,
        duration: TimeInterval,
        url: URL? = nil,
        coverUrl: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.url = url
        self.coverUrl = coverUrl
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.album = try container.decode(String.self, forKey: .album)
        self.duration = TimeInterval(try container.decode(Int.self, forKey: .duration))
        self.url = try container.decode(URL.self, forKey: .url)
        self.coverUrl = try container.decode(URL.self, forKey: .coverUrl)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.artist, forKey: .artist)
        try container.encode(self.album, forKey: .album)
        try container.encode(self.duration, forKey: .duration)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.coverUrl, forKey: .coverUrl)
    }
    
    static var demo: Song {
        Song(
            id: 1,
            title: "Demo Song",
            artist: "Demo Artist",
            album: "Demo Album",
            duration: 240,
            url: URL(string: "https://file-examples.com/storage/feaa6a7f0468517af9bc02d/2017/11/file_example_MP3_2MG.mp3"),
            coverUrl: URL(string: "https://media1.jpc.de/image/w1155/front/0/0828765355629.jpg")
        )
    }
}
