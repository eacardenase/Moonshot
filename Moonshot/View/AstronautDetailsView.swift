//
//  AstronautView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/24/26.
//

import SwiftUI

struct AstronautDetailsView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground.gradient)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    AstronautDetailsView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
