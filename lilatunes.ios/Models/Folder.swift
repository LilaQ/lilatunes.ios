//
//  Folder.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import Foundation

struct Folder: Codable, Identifiable {
    
    var name: String
    var subpath: String
    
    var id: String { subpath }      //  conform to identiable
    
    static var demo: [Folder] {
        [
            .init(name: "Demo1", subpath: "Demo1"),
            .init(name: "Demo2", subpath: "Demo2"),
            .init(name: "Demo3", subpath: "Demo3")
        ]
    }
}
