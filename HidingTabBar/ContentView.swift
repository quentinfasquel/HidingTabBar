//
//  ContentView.swift
//  HidingTabBar
//
//  Created by Quentin Fasquel on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var selectedTab: Tab = .red

    enum Tab {
        case red, green
        var title: String {
            switch self {
            case .red: "Red tab"
            case .green: "Green tab"
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedTab) {
                colorView(.red).tabItem {
                    Label("Red Tab", systemImage: "1.circle.fill")
                }.tag(Tab.red).overlay {
                    Button(action: {
                        withAnimation { path.append(Color.yellow) }
                    }) {
                        Text("Push a yellow view")
                    }
                }

                colorView(.green).tag(Tab.green).tabItem {
                    Label("Green Tab", systemImage: "1.circle.fill")
                }
            }
            .navigationTitle(selectedTab.title)
            .navigationDestination(for: Color.self) { newColor in
                colorView(newColor, "View at \(path.count)")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .tint(.white)
    }
    
    func colorView(_ color: Color, _ title: String? = nil) -> some View {
        ZStack {
            color.ignoresSafeArea()
        }
        .navigationTitle(title ?? "")
    }
}

#Preview {
    ContentView()
}
