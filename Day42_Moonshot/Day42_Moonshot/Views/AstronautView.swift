//
//  AstronautView.swift
//  Day42_Moonshot
//
//  Created by cem on 7.08.2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: AstronautModel

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
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: AstronautModel] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
