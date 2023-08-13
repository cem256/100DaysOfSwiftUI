//
//  EditViewModel.swift
//  Day73_Bucketlist
//
//  Created by cem on 13.08.2023.
//

import Foundation

@MainActor class EditViewModel: ObservableObject {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Published var name: String
    @Published var description: String
    @Published private(set) var loadingState: LoadingState
    @Published private(set) var pages : [Page]
    
    init(name : String, description : String) {
        loadingState = .loading
        pages = []
        
        self.name = name
        self.description = description
    }
    
    func fetchNearbyPlaces(location: Location) async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
    
}
