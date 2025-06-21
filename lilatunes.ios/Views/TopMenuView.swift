//
//  TopMenu.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUI

// Top bar, glued to safe area top, always at the top
struct TopMenuView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    settingsViewModel.isShowing.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .background(Color.black)
                }
                Spacer()
            }
            .frame(height: 40)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.black)
        }
        .background(.ultraThinMaterial)
        .foregroundColor(.white)
        .sheet(isPresented: $settingsViewModel.isShowing) {
            SettingsView()
        }
    }
}

#Preview {
    TopMenuView()
        .environmentObject(SettingsViewModel())
}
