//
//  PexesoThemeChooserViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 28/07/2025.
//

import UIKit

class PexesoThemeChooserViewController: UIViewController {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓⛷️🏏⛳️",
        "Animals": "🐶🦑🐠🪼🦉🐭🦊🐻🐼🐻‍❄️🐨🐯🦁",
        "Faces": "🙂😉😍🤓😎😇🧐😟😢🥶😱"
    ]
    
    private enum Segue: String {
        case chooseTheme = "Choose Theme"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // check which segue we're doing - we have 1 here for choosing theme
        if segue.identifier == Segue.chooseTheme.rawValue {
            // can we find pexeso MVC, and prepare it to telling him its 'theme'
            // is Any? type actually UIButton
            // (sender as? UIButton)? - can return nil -> needs optional chain it
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                // segue.destination - is UIViewController
                if let pexesoVC = segue.destination as? PexesoViewController {
                    print("prepareForSegue: setting theme = \(themeName)")
                    pexesoVC.theme = theme
                } // cannot write like this: segue.destination.theme = theme, doesn't have theme UIViewC
            }
        } else {
            print("prepareForSegue failed: sender or theme not found")
        }
    }
}

// segue creates always new MVC, destroy old one when going back in navigation
