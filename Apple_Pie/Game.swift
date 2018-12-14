//
//  Game.swift
//  Apple_Pie
//
//  Created by Bart Witting on 07/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import Foundation
struct Game {
    var word : String
    var incorrectMovesRemaining : Int
    var guessedLetters : [Character]
    
    /// This variable makes the stripped word and fills in the letters
    var formattedWord : String {
        var guessedWord = ""
        for char in word {
            if guessedLetters.contains(char) {
                guessedWord += "\(char)"
            }
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    /// Function to check the guessedletters and store them
    mutating func playerGuessed(letter:Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}

let wordsList : [String] = ["appel", "fiets", "eetlepel", "teennagelschaartje", "jazzzangeres"]
