//
//  ViewController.swift
//  Apple_Pie
//
//  Created by Bart Witting on 07/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWord: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var words : [String] = ["appel", "fiets", "eetlepel", "teenschaartje", "jazzzangeres"]
    
    let incorrectMovesAllowed = 7
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
    
    var currentGame : Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGamestate()
    }
    
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
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        correctWord.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
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
    
    func enableLetterButtons(_ b:Bool) {
        for button in letterButtons {
            button.isEnabled = b
        }
    }
}

