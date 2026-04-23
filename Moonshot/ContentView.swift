//
//  ContentView.swift
//  Moonshot
//
//  Created by Edwin Cardenas on 4/22/26.
//

import SwiftUI

struct Address: Codable {
    let street: String
    let city: String
}

struct User: Codable {
    let name: String
    let address: Address
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashvile"
                    }
                }
                """

            if let data = input.data(using: .utf8),
                let user = try? JSONDecoder().decode(User.self, from: data)
            {
                print(user.address.street)
            }
        }
    }
}

#Preview {
    ContentView()
}
