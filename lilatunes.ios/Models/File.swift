//
//  File.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import Foundation

struct File: Codable, Identifiable {
    
    var name: String
    var subpath: String
    
    var id: String { subpath }      //  conform to identiable
    
    static var demo: [File] {
        [
            .init(name: "demo1.mp3", subpath: "subpath/demopath1"),
            .init(name: "demo2.mp3", subpath: "subpath/demopath2"),
            .init(name: "demo3.mp3", subpath: "subpath/demopath3")
        ]
    }
}
