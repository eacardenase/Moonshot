//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                        .frame(width: 80, height: 80)
                        .background(.red.gradient)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .clipShape(.rect(cornerRadius: 8))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
