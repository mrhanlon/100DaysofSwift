//
//  ContentView.swift
//  WordScramble
//
//  Created by Matthew Hanlon on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @FocusState private var focused: Bool;

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focused)
                } footer: {
                    VStack {
                        Spacer()
                        Text("Points: \(score())")
                            .font(.headline)
                    }
                }


                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(scoreWord(word)).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New word") {
                    withAnimation {
                        usedWords.removeAll()
                    }
                    startGame()
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") {
                    focused = true
                }
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else { return }

        guard isLongEnough(answer) else {
            wordError(title: "Word too short", message: "Words must be at least three letters long!")
            return
        }

        guard isNotRootWord(answer) else {
            wordError(title: "Word is unoriginal", message: "You can't use the same word!")
            return
        }

        guard isUnused(answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        focused = true
    }

    func isNotRootWord(_ word: String) -> Bool {
        word != rootWord
    }

    func isLongEnough(_ word: String) -> Bool {
        word.count >= 3
    }

    func isUnused(_ word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(_ word: String) -> Bool {
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

    func scoreWord(_ word: String) -> Int {
        switch word.count {
        case 8:
            return 20
        case 7:
            return 12
        case 6:
            return 10
        case 5:
            return 5
        case 4:
            return 2
        default:
            return 1
        }
    }

    func score() -> Int {
        usedWords.reduce(0) { partial, word in
            partial + scoreWord(word)
        }
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                focused = true
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
}

#Preview {
    ContentView()
}
