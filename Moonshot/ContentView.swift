//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")

    var body: some View {
        Text(String(astronauts.count))
            .onAppear {
                print(astronauts)
            }
    }
}

#Preview {
    ContentView()
}
