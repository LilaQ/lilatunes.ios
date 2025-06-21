//
//  SettignsView.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("App")) {
                    withAnimation {
                        Toggle("Dark Mode", isOn: $settingsViewModel.useDarkMode)
                    }
                    Stepper("Font Size", value: .constant(14), in: 10...20)
                }

                Section {
                    Button("Sign Out", action: { /* handle sign out */ })
                        .foregroundColor(.red)
                }
                
                Section(header: Text("Account")) {
                    NavigationLink("Profile", destination: ProfileSettingsView())
                    NavigationLink("Security", destination: SecuritySettingsView())
                }
                Section(header: Text("App")) {
                    NavigationLink("Appearance", destination: AppearanceSettingsView())
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(settingsViewModel.useDarkMode ? .dark : .light)
    }
}

// Example sub-page
struct ProfileSettingsView: View {
    var body: some View {
        Form {
            Text("Change your name, photo, etc.")
        }
        .navigationTitle("Profile")
    }
}

struct SecuritySettingsView: View {
    var body: some View {
        Form {
            Text("Change your password, 2FA, etc.")
        }
        .navigationTitle("Security")
    }
}

struct AppearanceSettingsView: View {
    var body: some View {
        Form {
            Text("Dark mode, font size, etc.")
        }
        .navigationTitle("Appearance")
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
