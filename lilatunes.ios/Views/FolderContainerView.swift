//
//  FolderContainerView.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUI

struct FolderContainerView: View {
    var body: some View {
        NavigationStack {
            FolderView()
        }
    }
}

#Preview {
    @Previewable @StateObject var folderViewModel: FolderViewModel = FolderViewModel.demo
    @Previewable @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    FolderContainerView()
        .environmentObject(folderViewModel)
        .environmentObject(settingsViewModel)
        
}
