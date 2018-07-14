//
//  ViewController.swift
//  Morse Code
//
//  Created by Al Mobin on 13/7/18.
//  Copyright © 2018 Al Mobin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentState = "morse-to-text"
    lazy var inputLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Input"
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    lazy var outputLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Output"
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    lazy var inputTextfield : UITextField = {
        var textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Enter valid Morse Code with SPACE after every charecter"
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    lazy var outputTextArea : UITextField = {
        var textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Output Section"
        textfield.borderStyle = .roundedRect
        textfield.isEnabled = true
        return textfield
    }()
    
    lazy var translateButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:1.00, green:0.34, blue:0.13, alpha:1.0)
        button.setTitle("Translate", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(translate), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Morse Code To Text"
        
        self.inputTextfield.delegate = self
        self.outputTextArea.delegate = self

        layout()
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "convert2"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(ViewController.addTapped), for: UIControlEvents.touchUpInside)

        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.34, blue:0.13, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let yourBackImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)
    }
    
    
    func layout() {
        setupInputLabel()
        setupTextField()
        setupOutputLabel()
        setupTextArea()
        setupTranslateButton()
    }
    func setupInputLabel() {
        view.addSubview(inputLabel)
        inputLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        inputLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    func setupTextField() {
        view.addSubview(inputTextfield)
        inputTextfield.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 16).isActive = true
        inputTextfield.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inputTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        inputTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func setupOutputLabel() {
        view.addSubview(outputLabel)
        outputLabel.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 16).isActive = true
        outputLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    func setupTextArea() {
        view.addSubview(outputTextArea)
        outputTextArea.topAnchor.constraint(equalTo: outputLabel.bottomAnchor, constant: 16).isActive = true
        outputTextArea.heightAnchor.constraint(equalToConstant: 100).isActive = true
        outputTextArea.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        outputTextArea.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func setupTranslateButton() {
        view.addSubview(translateButton)
        translateButton.topAnchor.constraint(equalTo: outputTextArea.bottomAnchor, constant: 16).isActive = true
        translateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        translateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        translateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    @objc func translate() {
        guard let text = self.inputTextfield.text else { return }
        let modifiedText = text.replacingOccurrences(of: "-", with: "_", options: .literal, range: nil)
        if modifiedText != "" {
            if  self.currentState == "morse-to-text" {
                self.morseToText(morese: modifiedText)
            }
            else {
                self.textToMorse(text: modifiedText.uppercased())
            }
        }
    }
    
    @objc func addTapped() {
        if  self.currentState == "morse-to-text" {
            self.currentState = "text-to-morse"
            self.title = "Text To Morse Code"
            self.inputTextfield.text = ""
            self.outputTextArea.text = ""
            self.inputTextfield.placeholder = "Enter valid Text with SPACE after every charecter"
        }
        else {
            self.currentState = "morse-to-text"
            self.title = "Morse Code To Text"
            self.inputTextfield.text = ""
            self.inputTextfield.placeholder = "Enter valid Morse Code with SPACE after every charecter"
            self.outputTextArea.text = ""
        }
    }
    
    func morseToText(morese: String) {
        var result : String = ""
        let explodedArray = morese.components(separatedBy: " ")
        for char in explodedArray {
            switch char {
            case "._":
                result = result + "A"
            case "_...":
                result = result + "B"
            case "_._.":
                result = result + "C"
            case "_..":
                result = result + "D"
            case ".":
                result = result + "E"
            case ".._.":
                result = result + "F"
            case "__.":
                result = result + "G"
            case "....":
                result = result + "H"
            case "..":
                result = result + "I"
            case ".___":
                result = result + "J"
            case "_._":
                result = result + "K"
            case "._..":
                result = result + "L"
            case "__":
                result = result + "M"
            case "_.":
                result = result + "N"
            case "___":
                result = result + "O"
            case ".__.":
                result = result + "P"
            case "__._":
                result = result + "Q"
            case "._.":
                result = result + "R"
            case "...":
                result = result + "S"
            case "_":
                result = result + "T"
            case ".._":
                result = result + "U"
            case "..._":
                result = result + "V"
            case ".__":
                result = result + "W"
            case "_.._":
                result = result + "X"
            case "_.__":
                result = result + "Y"
            case "__..":
                result = result + "Z"
            case "_____":
                result = result + "0"
            case ".____":
                result = result + "1"
            case "..___":
                result = result + "2"
            case "...__":
                result = result + "3"
            case "...._":
                result = result + "4"
            case ".....":
                result = result + "5"
            case "_....":
                result = result + "6"
            case "__...":
                result = result + "7"
            case "___..":
                result = result + "8"
            case "____.":
                result = result + "9"
            default:
                result = result + "*"
            }
            result = result + " "
        }
        self.outputTextArea.text = result
    }
    
    func textToMorse(text: String) {
        var result : String = ""
        let explodedArray = text.components(separatedBy: " ")
        for char in explodedArray {
            switch char {
            case "A":
                result = result + "._"
            case "B":
                result = result + "_..."
            case "C":
                result = result + "_._."
            case "D":
                result = result + "_.."
            case "E":
                result = result + "."
            case "F":
                result = result + ".._."
            case "G":
                result = result + "__."
            case "H":
                result = result + "...."
            case "I":
                result = result + ".."
            case "J":
                result = result + ".___"
            case "K":
                result = result + "_._"
            case "L":
                result = result + "._.."
            case "M":
                result = result + "__"
            case "N":
                result = result + "_."
            case "O":
                result = result + "___"
            case "P":
                result = result + ".__."
            case "Q":
                result = result + "__._"
            case "R":
                result = result + "._."
            case "S":
                result = result + "..."
            case "T":
                result = result + "_"
            case "U":
                result = result + ".._"
            case "V":
                result = result + "..._"
            case "W":
                result = result + ".__"
            case "X":
                result = result + "_.._"
            case "Y":
                result = result + "_.__"
            case "Z":
                result = result + "__.."
            case "0":
                result = result + "_____"
            case "1":
                result = result + ".____"
            case "2":
                result = result + "..___"
            case "3":
                result = result + "...__"
            case "4":
                result = result + "...._"
            case "5":
                result = result + "....."
            case "6":
                result = result + "_...."
            case "7":
                result = result + "__..."
            case "8":
                result = result + "___.."
            case "9":
                result = result + "____."
            default:
                result = result + "*"
            }
            result = result + " "
        }
        self.outputTextArea.text = result
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

