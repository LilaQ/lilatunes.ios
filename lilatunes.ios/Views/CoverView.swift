//
//  CoverView.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 18.06.25.
//

import SwiftUI

struct CoverView: View {
    
    @State private var showTopBar = true
    @ObservedObject var viewModel: CoverViewModel
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        ScrollView {
            // Invisible anchor at the top
            Color.clear
                .frame(height: 1)
                .id("top")
            
            Spacer()
                .frame(height: 20)
            
            //  cover art
            FullWidthSquareAsyncImage(
                url: viewModel.coverImageUrl,
                padding: 20
            )
            
            Spacer()
                .frame(height: 10)
            
            //  songname + artist + fav-icon
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.songName)
                        .font(.title.bold())
                    Text(viewModel.artistName)
                        .font(.callout)
                        .offset(y: -5)
                }
                Spacer()
                
                //  fav
                SpringyButton(action: {
                    withAnimation{
                        viewModel.toggleFavorite()
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(viewModel.isFavorite ? .green : .white)
                        .transition(.push(from: .top))
                }
            }
            .padding(.horizontal, 20)
            
            //  progress-bar
            Slider(value: $viewModel.currentTime, in: 0...viewModel.duration)
                .padding(.horizontal, 20)
                .accentColor(.green)
            
            //  time + duration
            HStack {
                Text(viewModel.currentTime.formattedTime)
                    .font(.caption)
                Spacer()
                Text(viewModel.duration.formattedTime)
                    .font(.caption)
            }
            .padding(.horizontal, 20)
            
            //  player
            HStack(spacing: 30) {
                
                //  shuffle
                Button(action: {
                    viewModel.isShuffled.toggle()
                }) {
                    Image(systemName: "shuffle")
                        .font(.system(size: 20))
                        .foregroundColor( !viewModel.isShuffled ? Color.init(hex: "#1db954") : .white)
                }
                
                Spacer()
                
                //  prev song
                Button(action: {
                    viewModel.prevSong()
                }) {
                    Image(systemName: "backward.end.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
                
                //  play / pause
                Button(action: {
                    viewModel.playPause()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor( !viewModel.isPlaying ? Color.init(hex: "#1db954") : .white)
                }
                
                //  next song
                Button(action: {
                    viewModel.nextSong()
                }) {
                    Image(systemName: "forward.end.fill")
                        .font(.system(size: 26))
                        .foregroundColor( .white)
                }
                
                Spacer()
                
                //  loop
                Button(action: {
                    viewModel.isLooped.toggle()
                }) {
                    Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                        .font(.system(size: 20))
                        .foregroundColor( !viewModel.isLooped ? Color.init(hex: "#1db954") : .white)
                }
            }
            .frame(height: 100)
            .padding(.horizontal, 20)
            
#if DEBUG
            Button(action: {
                withAnimation{
                    showTopBar.toggle()
                }
            }) {
                Text("# Toggle Top Bar #")
                    .foregroundColor(.red)
            }
            
            Button(action: {
                withAnimation{
                    toastManager.show("Error while adding Favorite")
                }
            }) {
                Text("# Trigger Toast Message #")
                    .foregroundColor(.red)
            }
#endif
            
        }
        .scrollIndicators(.visible)
        .scrollTargetBehavior(.viewAligned)
        .foregroundColor(.white)
        .background(
            LinearGradient(
                colors: [Color.init(hex: "#1db954"), Color.init(hex: "#000")],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(alignment: .top) {
            if showTopBar {
                //  static top player,
                //  shows when scrolled too far
                HStack {
                    
                    //  song name + artist name
                    VStack(alignment: .leading) {
                        Text(viewModel.songName)
                            .font(.callout)
                        Text(viewModel.artistName)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    //  toggle fav
                    SpringyButton(action: {
                        withAnimation{
                            viewModel.toggleFavorite()
                        }
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(viewModel.isFavorite ? .green : .white)
                    }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    //  play / pause button
                    Button(action: {
                        viewModel.playPause()
                    }) {
                        Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor( !viewModel.isPlaying ? Color.init(hex: "#1db954") : .white)
                    }
                }
                .transition(
                    .move(edge: .top)
                    .combined(with: .opacity)
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .shadow(radius: 5.0, y: 5)
                
            }
        }
    }
}

#Preview {
    CoverView(viewModel: CoverViewModel.demo())
        .environmentObject(ToastManager.shared)
}
