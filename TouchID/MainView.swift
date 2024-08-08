//
//  MainView.swift
//  TouchID
//
//  Created by 褚宣德 on 2024/8/8.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("EasyPass", systemImage: "figure.walk.circle")
                }

            SecAccessControlView()
                .tabItem {
                    Label("Keychain", systemImage: "rectangle.portrait.split.2x1.slash")
                }
        }
    }
}

#Preview {
    MainView()
}

