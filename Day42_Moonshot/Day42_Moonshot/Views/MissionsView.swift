//
//  MissionsView.swift
//  Day42_Moonshot
//
//  Created by cem on 7.08.2023.
//

import SwiftUI

struct MissionsView: View {
    let astronauts: [String: AstronautModel] = Bundle.main.decode("astronauts.json")
    let missions: [MissionModel] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionDetailView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
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

struct MissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionsView()
    }
}
