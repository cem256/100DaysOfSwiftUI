//
//  ProspectTabView.swift
//  Day85_HotProspects
//
//  Created by cem on 14.08.2023.
//

import SwiftUI

struct ProspectTabView: View {
    @StateObject var prospects = Prospects()

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }

            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }

            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }

            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct ProspectTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectTabView()
    }
}
