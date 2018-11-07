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
    
    var formattedWord : String {
        var guessedWord = ""
        for char in word.characters {
            if guessedLetters.contains(char) {
                guessedWord += "\(char)"
            }
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter:Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
