//
//  FavoritesCacheManager.swift
//  Day99_SnowSeeker
//
//  Created by cem on 18.08.2023.
//

import Foundation

final class FavoritesCacheManager: ObservableObject {
    private var resorts: Set<String>
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: ResortModel) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: ResortModel) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: ResortModel) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
