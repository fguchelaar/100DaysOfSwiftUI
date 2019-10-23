//
//  ContentView.swift
//  WordScramble
//
//  Created by Frank Guchelaar on 22/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    private var score: Int {
        usedWords.reduce(0) { $0 + $1.count }
    }

    var body: some View {

        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                List(usedWords, id: \.self) {
                    Text($0)
                    Spacer()
                    Image(systemName: "\($0.count).circle.fill")
                        .foregroundColor(.secondary)
                }

                Text("Found \(usedWords.count) words, using \(score) letters")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("New word", action: startGame))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func startGame() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Could not find start.txt in bundle")
        }

        guard let words = try? String(contentsOf: url)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines) else {
                fatalError("Could not load words from start.txt")
        }
        usedWords = [String]()
        rootWord = words.randomElement() ?? "keyboard"
    }

    func addNewWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard word.count > 0 else {
            return
        }

        guard isOriginal(word: word) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: word) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isValid(word: word) else {
            wordError(title: "Word not possible", message: "Use words with more than 3 letters, not copying the root word and is a real word.")
            return
        }

        usedWords.insert(word, at: 0)
        newWord = ""
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var sourceWord = rootWord

        for letter in word {
            if let index = sourceWord.firstIndex(of: letter) {
                sourceWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }

    func isValid(word: String) -> Bool {
        if word.count < 3 && word == rootWord {
            return false
        }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
