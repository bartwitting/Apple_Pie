//
//  ViewController.swift
//  Apple_Pie
//
//  Created by Bart Witting on 07/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// Defining outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWord: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordField: UITextField!
    @IBOutlet var letterButtons: [UIButton]!
    
    /// Defining variables
    var words : [String] = ["appel", "fiets", "eetlepel", "teenschaartje", "jazzzangeres"]
    let incorrectMovesAllowed = 7
    var currentGame : Game!
    
    /// Defining the win and lose variable and if change a following action
    var totalWins = 0 {
        didSet {
            let alert = UIAlertController(title: "You won!", message: "Well done! You guessed the word \"\(currentGame.word)\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next word", style: .default, handler: {action in self.newRound()}))
            present(alert, animated: true, completion: nil)
        }
    }
    var totalLosses = 0{
        didSet {
            let alert = UIAlertController(title: "You Lost..", message: "Shame! You didn't get \"\(currentGame.word)\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {action in self.newRound()}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    /// Building the app
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    /// Action for tapped letter to send that letter to check if in the word
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGamestate()
    }
    
    /// Action for entered whole word to check if empty and if it's the correct word
    @IBAction func wholeButPressed(_ sender: Any) {
        let guessedWord = wordField.text!.lowercased()
        if guessedWord.isEmpty {
            let empty = UIAlertController(title: "No word", message: "You didn't enter a word", preferredStyle: .alert)
            empty.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
            present(empty, animated: true, completion: nil)
        }
        else if guessedWord == currentGame.word {
            correctWord.text = guessedWord
            totalWins += 1
            wordField.text = ""
        }
        else {
            totalLosses += 1
        }
    }
    
    /// Function to start a new round by grabbing a new word
    func newRound() {
        if !words.isEmpty {
            let newWord = words.removeFirst()
            currentGame = Game(word:newWord, incorrectMovesRemaining:incorrectMovesAllowed, guessedLetters:[])
            enableLetterButtons(true)
            updateUI()
        }
        else {
            let alert = UIAlertController(title: "Done:)", message: "You won \(totalWins) times and lost \(totalLosses) times", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Bye", style: .default, handler: {action in exit(0)}))
            present(alert, animated: true, completion: nil)
            enableLetterButtons(false)
        }
    }
    
    /// Function to fill in the labels and the correct image
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        correctWord.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    /// Function to check how many moves are left
    func updateGamestate () {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            updateUI()
            totalWins += 1
            updateUI()
        }
        else {
            updateUI()
        }
    }
    
    /// Function to re-enable all the letter buttons
    func enableLetterButtons(_ b:Bool) {
        for button in letterButtons {
            button.isEnabled = b
        }
    }
}

