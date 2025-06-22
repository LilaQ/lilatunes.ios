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
    @StateObject private var toastManager = ToastManager.shared
    
    //  demo
    @StateObject var coverViewModelDemo = CoverViewModel(song: .demo)
        
    var body: some View {
        ZStack {
//            TopMenuView()
//            FolderContainerView()
            CoverView(viewModel: coverViewModelDemo)
        }
        .environmentObject(settingsViewModel)
        .environmentObject(folderViewModel)
        .environmentObject(toastManager)
        .toastOverlay(using: toastManager)
    }
}

#Preview {
    @Previewable @StateObject var folderViewModel: FolderViewModel = FolderViewModel.demo
    @Previewable @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    ContentView()
        .environmentObject(settingsViewModel)
        .environmentObject(folderViewModel)
}
