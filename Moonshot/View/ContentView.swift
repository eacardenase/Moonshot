//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: .darkBackground.mix(
                        with: .white,
                        by: 0.3
                    ),
                    location: 0
                ),
                Gradient.Stop(
                    color: .darkBackground,
                    location: 1
                ),
            ],
            startPoint: .topLeading,
            endPoint: .bottom
        )
    }
}

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 16) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(
                            mission: mission,
                            astronauts: astronauts
                        )
                    } label: {
                        VStack {
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                        }
                        .background(GradientBackground())
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }

    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(
                    mission: mission,
                    astronauts: astronauts
                )
            } label: {
                HStack(spacing: 32) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text(mission.formattedLaunchDate)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
            .listRowBackground(GradientBackground())
        }
        .listStyle(.plain)
    }
}

struct ContentView: View {
    @State private var showingGrid = true
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground.gradient)
            .preferredColorScheme(.dark)
            .scrollIndicators(.never)
            .toolbar {
                ToolbarItem {
                    Toggle(isOn: $showingGrid) {
                        showingGrid
                            ? Image(systemName: "list.bullet")
                            : Image(systemName: "square.grid.2x2")
                    }
                    .tint(.darkBackground)
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
