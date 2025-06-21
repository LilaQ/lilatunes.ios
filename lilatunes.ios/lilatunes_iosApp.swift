//
//  lilatunes_iosApp.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

import SwiftUI

@main
struct lilatunes_iosApp: App {
    
    @StateObject var coverViewModel: CoverViewModel = .init(song: .demo)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            CoverView(viewModel: coverViewModel)
        }
    }
}
