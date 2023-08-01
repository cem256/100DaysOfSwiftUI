//
//  ContentView.swift
//  Day25_Challange
//
//  Created by cem on 1.08.2023.
//

import SwiftUI

enum Move: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct ContentView: View {
    @State private var score = 0
    @State private var turns = 0
    @State private var appMove = Move.rock
    @State private var shouldWin = true
    @State private var playerMove: Move?
    
    private var possibleMoves: [Move] = [.rock, .paper, .scissors]
    
    private func newTurn() {
        turns += 1
        appMove = possibleMoves.randomElement()!
        shouldWin = Bool.random()
        playerMove = nil
    }
    
    private func checkResult() {
        guard let playerMove = playerMove else { return }
        if shouldWin {
            if (playerMove == .rock && appMove == .scissors) ||
                (playerMove == .paper && appMove == .rock) ||
                (playerMove == .scissors && appMove == .paper) {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if (playerMove == .rock && appMove == .paper) ||
                (playerMove == .paper && appMove == .scissors) ||
                (playerMove == .scissors && appMove == .rock) {
                score += 1
            } else {
                score -= 1
            }
        }
        
        if turns == 10 {
            // Game Over
        } else {
            newTurn()
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Score: \(score)").font(.largeTitle)
                Text("Turns: \(turns)/10")
                Spacer()
                
                Text("\(appMove.rawValue)").font(.title)
                
                shouldWin ?
                Text("You should win with:")
                :
                Text("You should lose with:")
                
                
                HStack {
                    ForEach(possibleMoves, id: \.self) { move in
                        Button(action: {
                            playerMove = move
                            checkResult()
                        }) {
                            Text(move.rawValue)
                        }
                    }
                }
                Spacer()
            }.font(.title3)
        }
        
        .onAppear {
            newTurn()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
