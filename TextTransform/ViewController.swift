//
//  ViewController.swift
//  TextTransform
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var type: NSSegmentedControl!
    @IBOutlet weak var output: NSTextField!
    let zalgoCharacters = ZalgoCharacters()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typeChanged(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func rot13(input: String) -> String {
        return ROT13.string(input: input)
    }
    
    func similar(input: String) -> String {
        var output = input
        
        output = output.replacingOccurrences(of: "a", with: "а")
        output = output.replacingOccurrences(of: "e", with: "е")
        output = output.replacingOccurrences(of: "E", with: "Е")
        output = output.replacingOccurrences(of: "i", with: "і")
        
        return output
    }
    
    func strike(input: String) -> String {
        var output = ""
        
        for letter in input {
            output.append(letter)
            output.append("\u{0335}")
        }
        return output
    }
    
    func zalgo(input: String) -> String {
        var output = ""
        
        for letter in input {
            output.append(letter)
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.above.randomElement())
            }
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.inline.randomElement())
            }
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.below.randomElement())
            }
            
        }
        
        return output
    }


    @IBAction func typeChanged(_ sender: Any) {
        switch type.selectedSegment {
        case 0:
            output.stringValue = rot13(input: input.stringValue)
        case 1:
            output.stringValue = similar(input: input.stringValue)
        case 2:
            output.stringValue = strike(input: input.stringValue)
        default:
            output.stringValue = zalgo(input: input.stringValue)
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }

    @IBAction func copyToPasteboard(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(output.stringValue, forType: .string)
        
    }
}

extension String {
    mutating func append(_ str: String? ) {
        guard let str = str else { return }
        append(str)
    }
}
