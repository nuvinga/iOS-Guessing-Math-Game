//
//  MainTabView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

struct MainTabView: View {
    
    @AppStorage ("selectedColor") private var selectedColor: String = CustomColor.Emerald.rawValue

    var body: some View {
        TabView {
            GameView()
                .tabItem {
                    Label("Guess", systemImage: "checkmark.circle.badge.questionmark.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle.fill")
                }
        }
//        .tint(Color(selectedColor))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
