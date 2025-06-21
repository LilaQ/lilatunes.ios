//
//  FolderViewModel.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import Foundation

class FolderViewModel: ObservableObject {
    
    @Published var currentFolder: Folder = Folder(name: "", subpath: "")    //  current folder we're in
    @Published var folders: [Folder]                                        //  subfolders in the current folder
    @Published var files: [File]                                            //  files in the current folder
    
    init(folder: Folder, folders: [Folder] = [], files: [File] = []) {
        self.currentFolder = folder
        self.folders = folders
        self.files = files
    }
    
    func loadFolder(folder: Folder) {
        //  todo    API Call
    }
    
    static var demo: FolderViewModel {
        return FolderViewModel(
            folder: Folder(
                name: "Demo Folder",
                subpath: "/subpath/to/this/folder"),
            folders: Folder.demo,
            files: File.demo
            )
    }
}
