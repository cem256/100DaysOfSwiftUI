//
//  EditCardsView.swift
//  Day91_Flashzilla
//
//  Created by cem on 16.08.2023.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var contentViewModel: ContentViewModel
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card"){
                        contentViewModel.addCardToCache(promt: newPrompt, answer: newAnswer)
                        newPrompt = ""
                        newAnswer = ""
                    }
                }
                
                Section {
                    ForEach(contentViewModel.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete{indexSet in
                        contentViewModel.removeCardFromCache(at: indexSet)
                    }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear{
                contentViewModel.loadData()
            }
        }
    }
    
    func done() {
        dismiss()
    }

    
 
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView(contentViewModel : ContentViewModel())
    }
}
