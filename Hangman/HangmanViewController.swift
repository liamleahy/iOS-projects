//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

enum Images: String {
    case one = "hangman1.gif", two = "hangman2.gif", three = "hangman3.gif", four = "hangman4.gif", five = "hangman5.gif", six = "hangman6.gif", seven = "hangman7.gif"
    static let allValues = [one, two, three, four, five, six, seven]
}

class HangmanViewController: UIViewController {
    
    var hangman = Hangman()
    var currentImage: String?
    var allValues = 0


    
    @IBAction func startOver(sender: UIButton) {
        hangman.restart()
        allValues = 0
        updatedViews(false)
    }
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var knownWord: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var guessText: UITextField!
    @IBAction func newGame(sender: UIButton) {
        image.image = nil
        guessesLabel.text = ""
        guessText.text = ""
        hangman.start()
        allValues = 0
        image.image = UIImage(named: Images.allValues[allValues].rawValue)
        knownWord.text = hangman.knownString
        guessButton.enabled = true
    }
    
    @IBAction func guess(sender: UIButton) {
        var failed: Bool = false
        let text = guessText.text
        if !evalText(text!) {
            let alert = UIAlertController(title: "Please Enter a Valid Character", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                self.guessText.text = ""
            })
            return
        }
        let ret = hangman.guessLetter(guessText.text!.uppercaseString)
        if hangman.hasWon() {
            updatedViews(failed)
            let alert = UIAlertController(title: "You Won!", message: "Great Job...", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            guessButton.enabled = false
            return
        }
        if !ret {
            allValues += 1
            if allValues == 6 {
                let alert = UIAlertController(title: "You Lost!", message: "Great Job...", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                guessButton.enabled = false
                failed = true
            }
        }
        updatedViews(failed)
    }
    
    func updatedViews(failed: Bool) {
        guessText.text = ""
        if failed {
            knownWord.text = hangman.answer
        } else {
            knownWord.text = hangman.knownString
        }
        guessesLabel.text = hangman.guesses()
        image.image = UIImage(named: Images.allValues[allValues].rawValue)
    }
    
    /* Determines whether or not the text is a single character letter. */
    func evalText(text: String) -> Bool {
        let letters = NSCharacterSet.letterCharacterSet()
        if text.characters.count != 1 || !letters.longCharacterIsMember((text.unicodeScalars.first?.value)!) {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessButton.enabled = false
    }
}

