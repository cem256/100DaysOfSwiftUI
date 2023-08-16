//
//  ContentView.swift
//  Day91_Flashzilla
//
//  Created by cem on 16.08.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var contentViewModel : ContentViewModel = ContentViewModel()

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()

            VStack {
                Text("Time: \(contentViewModel.timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())

                ZStack {
                    ForEach(Array(contentViewModel.cards.enumerated()), id: \.element.id) { index, card in
                        CardView(card: card) {
                            withAnimation {
                                contentViewModel.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: contentViewModel.cards.count)
                        .allowsHitTesting(index == contentViewModel.cards.count - 1)
                        .accessibilityHidden(index < contentViewModel.cards.count - 1)
                    }

                }
                .allowsHitTesting(contentViewModel.timeRemaining > 0)

                if contentViewModel.cards.isEmpty {
                    Button("Start Again"){
                        contentViewModel.resetCards()
                    }
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        contentViewModel.showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                contentViewModel.removeCard(at: contentViewModel.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")

                        Spacer()

                        Button {
                            withAnimation {
                                contentViewModel.removeCard(at: contentViewModel.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer is being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard contentViewModel.isActive else { return }

            if contentViewModel.timeRemaining > 0 {
                contentViewModel.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if contentViewModel.cards.isEmpty == false {
                    contentViewModel.isActive = true
                }
            } else {
                contentViewModel.isActive = false
            }
        }
        .sheet(isPresented: $contentViewModel.showingEditScreen, onDismiss: contentViewModel.resetCards) {
            EditCardsView(contentViewModel: contentViewModel)
        }
        .onAppear(perform: contentViewModel.resetCards)
    }

   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
