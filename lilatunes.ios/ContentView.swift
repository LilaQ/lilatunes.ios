//
//  ContentView.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @StateObject var folderViewModel: FolderViewModel = FolderViewModel(folder: Folder(name: "", subpath: ""))
        
    var body: some View {
        VStack {
//            TopMenuView()
//            FolderContainerView()
            CoverView(viewModel: CoverViewModel.demo())
        }
        .environmentObject(settingsViewModel)
        .environmentObject(folderViewModel)
    }
}

#Preview {
    @Previewable @StateObject var folderViewModel: FolderViewModel = FolderViewModel.demo
    @Previewable @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    ContentView()
        .environmentObject(settingsViewModel)
        .environmentObject(folderViewModel)
}
