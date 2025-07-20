//
//  ViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Pexeso = Pexeso(numberOfCards: (numberOfPairsOfCards))
    //* e.x.: 5 buttons -> (5+1)/2 = 3 -> double them 6 (1 card more for odd)
    //    we need the number of cards -> add property into Pexeso class
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
                                           
    private(set) var flipCount = 0 {
        didSet {        // property observer
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func resetButton(_ sender: UIButton) {
        game.resetCards()
        updateViewFromModel()
        flipCount = 0
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
        
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
    private func updateViewFromModel() {
        for index in cardButtons.indices { // 0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 40)]
            
            // clicked button matches the card (that which is UP)
            if card.isFacedUp { // white face, not about btn title anymore
                let attributedString = NSAttributedString(string: emoji(for: card), attributes: attributes)
                button.setAttributedTitle(attributedString, for: .normal)
                button.backgroundColor = .systemGray6
            } else { // orange background
                // when the card is "matched" I still want to still when clicking on the second card as it's turned down
                let attributedString = NSAttributedString(string: "", attributes: attributes)
                button.setAttributedTitle(attributedString, for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.systemOrange.withAlphaComponent(0.3) : UIColor.systemOrange
            }
        }
    }
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    private var emojiDictionary: [Int:String] = [:]   // [Int:String]()
    
    private func emoji(for card: Card) -> String {
        // optional - firstly empty, then can be unwrapped
        // adding emoji when someone touch the screen at random
        // Once emojiChoices.count == 0, the range becomes 0..<0, which is empty, and Swift will crash at runtime
        
        if emojiDictionary[card.identifier] == nil, !emojiChoices.isEmpty { // no need to embeded another "if statements"
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            // add key-value pair into dictionary and remove it from the array as well
            emojiDictionary[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?" // if dictionary is not empty return, if so then "?"
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
