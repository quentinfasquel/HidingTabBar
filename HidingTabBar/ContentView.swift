//
//  ContentView.swift
//  HidingTabBar
//
//  Created by Quentin Fasquel on 15/01/2024.
//

import SwiftUI


struct Item: Hashable {
    var color: Color
    var index: Int
}

struct ContentView: View {
    @State private var path1 = NavigationPath()
    @State private var path2 = NavigationPath()
    @State private var selectedTab: Tab = .tab1
    
    enum Tab {
        case tab1, tab2
        var title: String {
            switch self {
            case .tab1: "Red tab"
            case .tab2: "Green tab"
            }
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $path1) {
                itemView(Item(color: .red, index: 0), path: $path1, prefix: "Tab 1")
                    .navigationDestination(for: Item.self) { newItem in
                        itemView(newItem, path: $path1, prefix: "Tab 1")
                            .navigationBarTitleDisplayMode(.inline)
                    }
            }
            .tabItem { Label("Tab 1", systemImage: "1.circle.fill") }
            .tag(Tab.tab1)

            NavigationStack(path: $path2) {
                itemView(Item(color: .green, index: 0), path: $path2, prefix: "Tab 2")
                    .navigationDestination(for: Item.self) { newItem in
                        itemView(newItem, path: $path2, prefix: "Tab 2")
                            .navigationBarTitleDisplayMode(.inline)
                    }
            }
            .tabItem { Label("Tab 2", systemImage: "2.circle.fill") }
            .tag(Tab.tab2)
        }
        .tint(.white)
    }
    
    func itemView(_ item: Item, path: Binding<NavigationPath>, prefix titlePrefix: String) -> some View {
        ZStack {
            item.color.ignoresSafeArea()
            
            Button(action: {
                let pathCount = path.wrappedValue.count
                let newItem = Item(color: .yellow, index: pathCount + 1)
                path.wrappedValue.append(newItem)
            }) {
                Text("Push a yellow view")
            }
        }
        .navigationTitle("\(titlePrefix) at \(item.index)")
    }
}

#Preview {
    ContentView()
}
