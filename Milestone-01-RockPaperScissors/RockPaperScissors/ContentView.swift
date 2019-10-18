//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Frank Guchelaar on 18/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct EmojiButton: View {
    var emoji: String

    var body: some View {
        ZStack {
            Color.blue
            Text(emoji)
                .font(Font.system(size: 48))
        }
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))

        .shadow(color: .black, radius: 2)

    }
}

struct ContentView: View {

    let moves = ["Rock", "Paper", "Scissors"]
    let emoji = ["✊","✋","✌️"]

    @State var currentChoice = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0

    @State var isPresenting = false
    @State var alertTitle = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Text("I've played \(emoji[currentChoice])")
                    .font(.title)

                VStack {
                    Text("Select the correct move to ")
                    Text(shouldWin ? "win" : "lose")
                        .bold()
                }

                HStack(spacing: 20) {
                    ForEach(0..<moves.count) { number in
                        Button(action: {
                            self.playMove(number)
                        }) {
                            EmojiButton(emoji: self.emoji[number])
                        }
                    }
                }
                Text("Score: \(score)")
                Spacer()
            }.alert(isPresented: $isPresenting) {
                Alert(title: Text(alertTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("OK")) {
                    self.nextRound()
                    })
            }.padding(.top, 30)
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
