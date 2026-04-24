//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(mission.crew, id: \.name) { crewMember in
                    Text(crewMember.name)
                }
            }
            .navigationTitle(mission.displayName)
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout, spacing: 16) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission)
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
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                            }
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(
                                            color: .white,
                                            location: 0
                                        ),
                                        Gradient.Stop(
                                            color: .darkBackground.mix(
                                                with: .white,
                                                by: 0.5
                                            ),
                                            location: 0.38
                                        ),
                                        Gradient.Stop(
                                            color: .darkBackground,
                                            location: 0.9
                                        ),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottom
                                )
                            )
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
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
