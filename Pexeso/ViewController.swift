//
//  ViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet {        // property observer
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻", "🎃", "👻", "🎃"]
    
    @IBAction func pressButton(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card not found in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 50)]
        
        // Showing emoji, flip down
        if button.attributedTitle(for: .normal)?.string == emoji {
            let emptyTitle = NSAttributedString(string: "", attributes: attributes)
            button.setAttributedTitle(emptyTitle, for: .normal)
            button.backgroundColor = .systemOrange
        } else { // Back of the card, flip Up
            let attributedEmoji = NSAttributedString(string: emoji, attributes: attributes)
            button.setAttributedTitle(attributedEmoji, for: .normal)
            button.backgroundColor = .white
            
            // Force re-layout if needed
             button.setNeedsLayout()
             button.layoutIfNeeded()
        }
    }

}

// Using setAttributedTitle(...) bypasses UIKit's buggy font inheritance or layout pass, and gives total control over the font rendering regardless of what UIKit's internal layout engine does
//          button.setTitle("", for: UIControl.State.normal)
//          button.titleLabel?.font = UIFont.systemFont(ofSize: 50)

//          print("Font after setting: \(button.titleLabel?.font.debugDescription ?? "nil")")
