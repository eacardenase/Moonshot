//
//  MissionView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/24/26.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronautsData: [String: Astronaut] = Bundle.main.decode(
        "astronauts.json"
    )

    var astronautsList: [Astronaut] {
        mission.crew.compactMap { crewMember in
            astronautsData[crewMember.name]
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.7
                    }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Mission Highlights")
                        .font(.title.bold())

                    Text(mission.description)
                }

                Text("Crew")
                    .font(.title2.bold())

                ForEach(astronautsList) { astronaut in
                    NavigationLink {
                        Text("Astronaut Details View")
                    } label: {
                        Text(astronaut.name)
                            .font(.headline)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .background(.darkBackground.gradient)
        .scrollIndicators(.never)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")

    MissionView(mission: missions[0])
        .preferredColorScheme(.dark)
}
