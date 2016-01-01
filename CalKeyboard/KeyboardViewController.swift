//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var nextKeyboardButton: UIButton!
    @IBOutlet weak var deleteKeyboardButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var smileyButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var kappaButton: UIButton!
    var keyboardView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        deleteKeyboardButton.addTarget(self, action: "delete", forControlEvents: .TouchUpInside)
        sadButton.addTarget(self, action: "sad", forControlEvents: .TouchUpInside)
        smileyButton.addTarget(self, action: "smiley", forControlEvents: .TouchUpInside)
        neutralButton.addTarget(self, action: "neutral", forControlEvents: .TouchUpInside)
        returnButton.addTarget(self, action: "returnFunc", forControlEvents: .TouchUpInside)
        kappaButton.addTarget(self, action: "kappaTapped", forControlEvents: .TouchUpInside)
    }
    
    func kappaTapped() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: "KappaHD.png")
        proxy.insertText((textAttachment.image?.description)!)
        let attributedString = NSAttributedString(attachment: textAttachment)
        proxy.
        proxy.insertText("kappa")
    }
    
    func delete() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    
    func sad() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(":-(")
    }
    
    func neutral() {
        let proxy = textDocumentProxy as UITextDocumentProxy 
        proxy.insertText(":-|")
    }
    
    func smiley() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(":-)")
    }
    
    func returnFunc() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\n")
    }
}
