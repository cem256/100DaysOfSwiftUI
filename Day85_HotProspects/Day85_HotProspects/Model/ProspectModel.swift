//
//  ProspectModel.swift
//  Day85_HotProspects
//
//  Created by cem on 14.08.2023.
//

import SwiftUI

class ProspectModel: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [ProspectModel]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([ProspectModel].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: ProspectModel) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: ProspectModel) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
