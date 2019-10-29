//
//  ContentView.swift
//  Animations
//
//  Created by Frank Guchelaar on 25/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var animationAmount: [Double] = [0,0,0]

    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.animationAmount[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(number != self.correctAnswer && self.showingScore ? 0.75 : 1)
                    .animation(.default)
                }

                Text("Score: \(score)")
                    .foregroundColor(.white)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }

    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            withAnimation {
                animationAmount[number] += 360
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            score = max(0, score - 1)
        }

        showingScore = true
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    let name: String

    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
