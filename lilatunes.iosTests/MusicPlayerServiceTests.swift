//
//  MusicPlayerServiceTests.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 22.06.25.
//

import XCTest
import AVFoundation
@testable import lilatunes_ios

final class MusicPlayerServiceTests: XCTestCase {
    var playerService: MusicPlayerService!
    var song1: Song!
    var song2: Song!
    var playlist1: Playlist!
    var playlist2: Playlist!
    
    override func setUpWithError() throws {
        playerService = MusicPlayerService.shared
        // Use dummy URLs (file URLs, since AVPlayer won't actually play during unit tests)
        song1 = Song(id: "#abcde123", title: "Song One", artist: "Artist One", album: "Album One", duration: 123, url: URL(filePath: "asd"), coverUrl: URL(filePath: "adsd"))
        song2 = Song(id: "#ghijk456", title: "Song Two", artist: "Artist Two", album: "Album Two", duration: 456, url: URL(filePath: "asd"), coverUrl: URL(filePath: "asdd"))
        playlist1 = Playlist(id: "#abc123", songs: [song1, song2], name: "Test Playlist #1")
        playlist2 = Playlist(id: "#def456", songs: [song2], name: "Test Playlist #2")
        // Ensure player is reset before each test
        playerService.stop()
    }

    override func tearDownWithError() throws {
        playerService.stop()
    }
    
    func testLoadSongSetsState() {
        playerService.load(song: song1)
        XCTAssertEqual(playerService.currentSong, song1)
        XCTAssertEqual(playerService.duration, song1.duration)
        XCTAssertEqual(playerService.currentTime, 0)
        XCTAssertFalse(playerService.isPlaying)
    }
    
    func testPlaySetsIsPlayingTrue() {
        playerService.load(song: song1)
        playerService.play()
        XCTAssertTrue(playerService.isPlaying)
    }
    
    func testPauseSetsIsPlayingFalse() {
        playerService.load(song: song1)
        playerService.play()
        playerService.pause()
        XCTAssertFalse(playerService.isPlaying)
    }
    
    func testStopResetsState() {
        playerService.load(song: song1)
        playerService.play()
        playerService.stop()
        XCTAssertNil(playerService.currentSong)
        XCTAssertFalse(playerService.isPlaying)
        XCTAssertEqual(playerService.currentTime, 0)
        XCTAssertEqual(playerService.duration, 0)
    }
    
    func testLoadSongWithPlaylistStoresPlaylist() {
        playerService.load(song: song1, playlist: playlist1)
        XCTAssertEqual(playerService.currentPlaylist, playlist1)
    }
    
    func testNextAdvancesToNextSong() {
        playerService.load(song: song1, playlist: playlist1)
        playerService.play()
        playerService.next()
        XCTAssertEqual(playerService.currentSong, song2)
        XCTAssertTrue(playerService.isPlaying)
    }
    
    func testNextDoesNothingAtEndOfPlaylist() {
        playerService.load(song: song2, playlist: playlist1)
        playerService.play()
        playerService.next()
        // Should still be on song2
        XCTAssertEqual(playerService.currentSong, song2)
        XCTAssertTrue(playerService.isPlaying)
    }
    
    func testPrevGoesToPreviousSong() {
        playerService.load(song: song2, playlist: playlist1)
        playerService.play()
        playerService.prev()
        XCTAssertEqual(playerService.currentSong, song1)
        XCTAssertTrue(playerService.isPlaying)
    }
    
    func testPrevDoesNothingAtStartOfPlaylist() {
        playerService.load(song: song1, playlist: playlist1)
        playerService.play()
        playerService.prev()
        XCTAssertEqual(playerService.currentSong, song1)
        XCTAssertTrue(playerService.isPlaying)
    }
}
