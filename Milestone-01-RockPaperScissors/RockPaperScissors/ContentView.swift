//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Frank Guchelaar on 18/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State var currentChoice = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0
    
    @State var isPresenting = false
    @State var alertTitle = ""
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
            Text("I've played \(moves[currentChoice])")
            Text("You should:")
            Text(shouldWin ? "win" : "loose")
            
            ForEach(0..<moves.count) { number in
                Button(action: {
                    self.playMove(number)
                }) {
                    Text(self.moves[number])
                }
            }
            Spacer()
        }.alert(isPresented: $isPresenting) {
            Alert(title: Text(alertTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("OK")) {
                self.nextRound()
                })
        }
    }
    
    func playMove(_ number: Int) {
        let app = moves[currentChoice]
        let player = moves[number]
        
        let playerWins = (app == "Rock" && player == "Paper")
            || (app == "Paper" && player == "Scissors")
            || (app == "Scissors" && player == "Rock")
        
        if (playerWins && shouldWin) || (!playerWins && !shouldWin) {
            score += 1
            alertTitle = "Well done"
        } else {
            score = max(0, score - 1)
            alertTitle = "Nope, not good"
        }
        isPresenting = true
    }
    
    private func nextRound() {
        currentChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
