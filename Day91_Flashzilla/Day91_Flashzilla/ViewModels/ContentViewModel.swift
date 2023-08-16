//
//  ContentViewModel.swift
//  Day91_Flashzilla
//
//  Created by cem on 16.08.2023.
//

import Foundation

@MainActor class ContentViewModel: ObservableObject {
    
    @Published private(set) var cards: [Card]
    @Published var timeRemaining : Int
    @Published var isActive: Bool
    @Published var showingEditScreen: Bool
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    init() {
        cards = []
        timeRemaining = 100
        isActive = true
        showingEditScreen = false
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func addCardToCache(promt :String, answer: String) {
        let trimmedPrompt = promt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = promt.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        
        saveData()
    }
    
    func removeCardFromCache(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
}
