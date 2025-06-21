//
//  SettingsViewModel.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var isShowing: Bool = false
    @Published var useDarkMode: Bool = false
}
