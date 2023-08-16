//
//  Card.swift
//  Day91_Flashzilla
//
//  Created by cem on 16.08.2023.
//

import Foundation

struct Card: Codable , Identifiable {
    var id : UUID = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
