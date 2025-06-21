//
//  FolderView.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUI

struct FolderView: View {
    
    @EnvironmentObject var folderViewModel: FolderViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        List {
            // Show folders first
            ForEach(folderViewModel.folders) { folder in
                NavigationLink(
                    destination: FolderView()
                        .onAppear {
                            folderViewModel.loadFolder(folder: folder)
                        }
                ) {
                    Label(folder.name, systemImage: "folder")
                }
            }
            // Then show files
            ForEach(folderViewModel.files) { file in
                Label(file.name, systemImage: "doc")
            }
        }
        .navigationTitle(folderViewModel.currentFolder.name)
        .preferredColorScheme(settingsViewModel.useDarkMode ? .dark : .light)
    }
}

#Preview {
    @Previewable @StateObject var folderViewModel: FolderViewModel = FolderViewModel.demo
    @Previewable @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    NavigationStack
    {
        FolderView()
            .environmentObject(folderViewModel)
            .environmentObject(settingsViewModel)
    }
}
