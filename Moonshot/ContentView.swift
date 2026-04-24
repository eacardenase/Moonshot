//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail view")
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
        }
    }
}

#Preview {
    ContentView()
}
