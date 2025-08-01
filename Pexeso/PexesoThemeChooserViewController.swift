//
//  PexesoThemeChooserViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 28/07/2025.
//

import UIKit

class PexesoThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    var themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🥏🎱🏓⛷️🏏⛳️",
        "Animals": "🐶🦑🐠🪼🦉🐭🦧🦊🐣🐻🪲🦁",
        "Faces": "🙂😉😍🤓😎😇🧐😟😢🥶😱"
    ]
    
    
    // MARK: - Navigation
    

    // Needs to add UISplitViewControllerDelegate
//    override func awakeFromNib() {
//        splitViewController?.delegate = self
//    }
    
    // without this func iPhone will enter game screen directly
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        if let pexesoVC = secondaryViewController as? PexesoViewController {
//            if pexesoVC.theme == nil {  // not chose yet
//                return true // show the theme screen default in iPhone
//            }
//        }
//        return false  // after chosen, enter the game screen in iPhone
//    }
    
//    @IBAction func changeTheme(_ sender: Any) { // *
//            // for iPad use splitView
//            // remember the state, don't refresh everything when changing the theme
//        if let pexesoVC = splitViewDetailPexesoViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                pexesoVC.theme = theme
//            }
//            // for iPhone use navigation
//            // remember the state, don't refresh all when change theme
//            // holding something in the heap which has thrown from navigation stack
//        } else if let pexesoVC = lastSeguedToPexesoViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                pexesoVC.theme = theme
//            }
//                //  and push things into it (navig. stack) without segueing
//            navigationController?.pushViewController(pexesoVC, animated: true)
//        } else {
//            performSegue(withIdentifier: "Choose Theme", sender: sender)    // segue from code
//        }
//    }
    
        // current splitVC I am in, its viewControllers primary detail and take the last one
//    private var splitViewDetailPexesoViewController: PexesoViewController? {
//        return splitViewController?.viewControllers.last as? PexesoViewController
//    }
    
    // MARK: - Navigation
        // *** normal var keeping in the heap
//    private var lastSeguedToPexesoViewController: PexesoViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            // **
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let pexesoVC = segue.destination as? PexesoViewController {
                    pexesoVC.theme = theme
                    print("prepareForSegue: setting theme = \(themeName)")
//                    lastSeguedToPexesoViewController = pexesoVC
                }
            }
        }
    }
}

// *
// connect each button from storyboard to this method
// create segue from one MVC to another - not manually from buttons only
// change themes in the middle of the game

// **
// (Bad design): We are getting the theme from the button's title
// check which segue we're doing - we have 1 here for choosing theme
// can we find pexeso MVC, and prepare it to telling him its 'theme'
// is Any? type actually UIButton
// (sender as? UIButton)? - can return nil -> needs optional chain it
    
// ***
// as we want to hit 'back' button to choose different theme on iPhone (doesn't have splitVC), it throws away MVC from Navigation Stack but pointing to this var
