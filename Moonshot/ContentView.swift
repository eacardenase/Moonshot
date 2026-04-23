//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        NavigationStack {
            NavigationLink {
                NavigationStack {
                    List {
                        ForEach(0..<10) {
                            Text("Item \($0)")
                        }
                    }
                    .navigationTitle("Detail View")
                    .toolbar {
                        ToolbarItem {
                            Button("Add", systemImage: "plus", role: .confirm) {
                                showingSheet = true
                            }
                        }
                    }
                    .sheet(isPresented: $showingSheet) {
                        Text("Sheet")
                    }
                }
            } label: {
                VStack {
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    ContentView()
}
