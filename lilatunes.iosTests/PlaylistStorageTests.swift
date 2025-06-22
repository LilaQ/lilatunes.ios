//
//  PlaylistStorageTests.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 22.06.25.
//

import XCTest

// Replace this with your actual module name if needed
@testable import lilatunes_ios

final class PlaylistStorageTests: XCTestCase {
    var storage: PlaylistStorage!
    let testPlaylistID = "test_playlist"
    let song1 = Song(id: "#abcde123", title: "Song One", artist: "Artist One", album: "Album One", duration: 123, url: URL(filePath: "asd"), coverUrl: URL(filePath: "adsd"))
    let song2 = Song(id: "#ghijk456", title: "Song Two", artist: "Artist Two", album: "Album Two", duration: 456, url: URL(filePath: "asd"), coverUrl: URL(filePath: "asdd"))
    
    override func setUpWithError() throws {
        storage = PlaylistStorage(playlist_id: testPlaylistID)
        // Remove any existing test file before each test
        let fileManager = FileManager.default
        let fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(testPlaylistID).json")
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(at: fileURL)
        }
    }
    
    override func tearDownWithError() throws {
        // Clean up test file after each test
        let fileManager = FileManager.default
        let fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(testPlaylistID).json")
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(at: fileURL)
        }
        storage = nil
    }
    
    func testSaveAndLoadEmptyPlaylist() throws {
        try storage.save(songs: [])
        let loaded = try storage.load()
        XCTAssertTrue(loaded.isEmpty)
    }
    
    func testAddSong() throws {
        try storage.add(song: song1)
        let loaded = try storage.load()
        XCTAssertEqual(loaded, [song1])
    }
    
    func testAddDuplicateSongDoesNotAddAgain() throws {
        try storage.add(song: song1)
        try storage.add(song: song1)
        let loaded = try storage.load()
        XCTAssertEqual(loaded, [song1])
    }
    
    func testRemoveSong() throws {
        try storage.save(songs: [song1, song2])
        try storage.remove(song: song1)
        let loaded = try storage.load()
        XCTAssertEqual(loaded, [song2])
    }
    
    func testRemoveNonexistentSongDoesNothing() throws {
        try storage.save(songs: [song2])
        try storage.remove(song: song1)
        let loaded = try storage.load()
        XCTAssertEqual(loaded, [song2])
    }
    
    func testContainsSong() throws {
        try storage.save(songs: [song1])
        XCTAssertTrue(try storage.contains(song: song1))
        XCTAssertFalse(try storage.contains(song: song2))
    }
    
    func testPersistenceBetweenSaves() throws {
        try storage.add(song: song1)
        var loaded = try storage.load()
        XCTAssertTrue(loaded.contains(song1))
        
        try storage.add(song: song2)
        loaded = try storage.load()
        XCTAssertTrue(loaded.contains(song1))
        XCTAssertTrue(loaded.contains(song2))
        
        try storage.remove(song: song1)
        loaded = try storage.load()
        XCTAssertFalse(loaded.contains(song1))
        XCTAssertTrue(loaded.contains(song2))
    }
}
