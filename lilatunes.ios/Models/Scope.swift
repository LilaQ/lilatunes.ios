//
//  Scope.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

struct Scope: Codable {
    let name: String
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case name
        case songs = "songs"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.songs, forKey: .songs)
    }
}
