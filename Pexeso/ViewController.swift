//
//  ViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Pexeso = Pexeso(numberOfCards: (cardButtons.count + 1))
    //* e.x.: 5 buttons -> (5+1)/2 = 3 -> double them 6 (1 card more for odd)
    //    we need the number of cards -> add property into Pexeso class
    
    var flipCount = 0 {
        didSet {        // property observer
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
        
    @IBAction func pressButton(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber) // say model to choose btn/card
            updateViewFromModel()
        } else {
            print("chosen card not found in cardButtons")
        }
    }
    
    //    Go through all Card buttons and set it up propertly
    //    & check each card instance in the cards
    func updateViewFromModel() {
        for index in cardButtons.indices { // 0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            
            // clicked button matches the card (that which is UP)
            if card.isFacedUp { // white face, not about btn title anymore
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = .white
            } else { // orange background
                button.setTitle("", for: UIControl.State.normal)
                // when the card is "matched" I still want to still when clicking on the second card as it's turned down
                button.backgroundColor = card.isMatched ? UIColor.systemOrange.withAlphaComponent(0.3) : UIColor.systemOrange
            }
        }
    }
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    func emoji(for: Card) -> String {
        return "?"
    }
}

// Using setAttributedTitle(...) bypasses UIKit's buggy font inheritance or layout pass, and gives total control over the font rendering regardless of what UIKit's internal layout engine does
//          button.setTitle("", for: UIControl.State.normal)
//          button.titleLabel?.font = UIFont.systemFont(ofSize: 50)

//          print("Font after setting: \(button.titleLabel?.font.debugDescription ?? "nil")")

// lazy -> it doesn't initialize until someone wants to use it (and is used once it is fully initialize :)
// with lazy var cannot use property observer didSet

// * to ensure you have enough pairs for the number of cards, even when the total number of buttons (cards) is odd.
// (cardButtons.count + 1) / 2) -> 5 / 2 = 2  → only 2 pairs = 4 cards (but you have 5 buttons!)
// cardButtons.indices -> is countable range of Int
