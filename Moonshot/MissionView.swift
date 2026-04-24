//
//  MissionView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/24/26.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [String: Astronaut]

    var crew: [CrewMember] {
        mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Missing \(member.name)")
            }

            return CrewMember(role: member.role, astronaut: astronaut)
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

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                Text("Astronaut Details")
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay {
                                            Capsule()
                                                .stroke(.white, lineWidth: 1)
                                        }

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)

                                        Text(crewMember.role)
                                            .foregroundStyle(
                                                .white.opacity(0.5)
                                            )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
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
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
