//
//  MissionView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/24/26.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .padding(.vertical)
    }
}

struct CrewMemberView: View {
    let crewMember: CrewMember

    var body: some View {
        HStack(spacing: 16) {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10, )
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
    }
}

struct MissionView: View {

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

                Text(mission.formattedLaunchDate)
                    .font(.callout)

                VStack(alignment: .leading, spacing: 8) {
                    RectangleDivider()

                    Text("Mission Highlights")
                        .font(.title.bold())

                    Text(mission.description)

                    RectangleDivider()

                    Text("Crew")
                        .font(.title2.bold())
                }

                ScrollView(.horizontal) {
                    HStack(spacing: 32) {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautDetailsView(
                                    astronaut: crewMember.astronaut
                                )
                            } label: {
                                CrewMemberView(crewMember: crewMember)
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

    MissionView(mission: missions[5], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
