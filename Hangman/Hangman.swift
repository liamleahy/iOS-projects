//
//  Hangman.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import Foundation

class Hangman {
    var words: HangmanWords!
    var answer: String?
    var knownString: String?
    var guessedLetters: NSMutableArray?
    
    init() {
        words = HangmanWords()
    }
    
    func restart() {
        makeKnownString()
        guessedLetters = NSMutableArray()
    }
    
    func makeKnownString() {
        knownString = ""
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if (answer! as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                knownString = knownString! + " "
            } else {
                knownString = knownString! + "_"
            }
        }
    }
    
    func start() {
        let word = words.getRandomWord()
        answer = word
        knownString = ""
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if (word as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                knownString = knownString! + " "
            } else {
                knownString = knownString! + "_"
            }
        }
        guessedLetters = NSMutableArray()
    }
    
    /* Returns true if we have guessed the letter or if the letter is contained in the answer.
     * If the letter is contained in the answer, then we update the knownString. 
     * If we haven't guessed the letter, updates the guessedLetters NSMutableArray. */
    func guessLetter(letter: String) -> Bool {
        var result = false
        if guessedLetters!.containsObject(letter) {
            return true
        }
        guessedLetters!.addObject(letter)
        var chars = Array(answer!.characters)
        
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if String(chars[i]) == letter {
                result = true
                knownString = "\((knownString! as NSString).substringToIndex(i))" + "\(letter)"
                            + "\((knownString! as NSString).substringFromIndex(i+1))"
            }
            
        }
        return result
    }
    
    /* Returns a string representation of all of the letters guessed so far. */
    func guesses() -> String {
        if guessedLetters!.count == 0 {
            return ""
        }
        var result: String = (guessedLetters?.objectAtIndex(0) as! String)
        for (var i = 1; i < guessedLetters!.count; i += 1) {
            result = result + ", \(guessedLetters?.objectAtIndex(i) as! String)"
        }
        return result
    }
    
    func hasWon() -> Bool {
        return answer != nil && knownString != nil && answer! == knownString!
    }

}