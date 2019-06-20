//
//  ViewController.swift
//  StamfordCourse
//
//  Created by Harut on 07/01/2019.
//  Copyright © 2019 Harut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game: Concentration = Concentration(numberOfPairOfCards:  numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount: Int = 0 {
        didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😼", "🤡", "🐷", "🙉", "🐣", "🐙", "🐳", "🦞", "🦉", "🐆", "🐘"]
    
    var emoji = [Card:String]()
    
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0...emojiChoices.count-1)
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card] ?? "?"
    }
    
}
