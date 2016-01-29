//
//  ViewController.swift
//  Calculator
//
//  Created by Arunjot Singh on 1/26/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIStatusBarStyle.LightContent
       }
    
    @IBOutlet weak var Log10: UIButton!
    @IBOutlet weak var eRaiseA: UIButton!
    @IBOutlet weak var ln: UIButton!
    @IBOutlet weak var xRaiseA: UIButton!
    @IBOutlet weak var Rand: UIButton!
    @IBOutlet weak var Percentage: UIButton!
    @IBOutlet weak var xFact: UIButton!
    @IBOutlet weak var yRootX: UIButton!
    @IBOutlet weak var twoRootX: UIButton!
    @IBOutlet weak var oneByX: UIButton!
    @IBOutlet weak var Pi: UIButton!
    
    @IBOutlet weak var displayScreen: UILabel!
    
    var disableFactorial = true
    var disableEquals = true
    var userTyping = false
    var firstNumber = Double()
    var secondNumber = Double()
    var result = Double()
    var operation = ""
    let pi = 3.14159
    
    override func viewDidLoad() {
        Log10.hidden = true
        ln.hidden = true
        Rand.hidden = true
        yRootX.hidden = true
        oneByX.hidden = true
     
    }
    
    @IBAction func moreOperations(sender: UIBarButtonItem) {
        if Log10.hidden == true {
            Log10.hidden = false
            eRaiseA.hidden = true
            ln.hidden = false
            xRaiseA.hidden = true
            Rand.hidden = false
            Percentage.hidden = true
            xFact.hidden = true
            yRootX.hidden = false
            twoRootX.hidden = true
            oneByX.hidden = false
            Pi.hidden = false
        } else {
            Log10.hidden = true
            eRaiseA.hidden = false
            ln.hidden = true
            xRaiseA.hidden = false
            Rand.hidden = true
            Percentage.hidden = false
            xFact.hidden = false
            yRootX.hidden = true
            twoRootX.hidden = false
            oneByX.hidden = true
            Pi.hidden = false
        }
    }
    @IBAction func digitTapped(sender: UIButton) {
        let digit = sender.currentTitle
        if userTyping == true {
            displayScreen.text = displayScreen.text! + digit!
        } else {
            displayScreen.text = digit
        }
        userTyping = true
        disableEquals = false
        disableFactorial = false
    }
   
    @IBAction func pointTapped(sender: UIButton) {
        let pointSymbol = sender.currentTitle!
        if userTyping {
            if displayScreen.text?.rangeOfString(pointSymbol) == nil {
                displayScreen.text = displayScreen.text! + pointSymbol
            }
        } else {
            userTyping = true
            displayScreen.text = "0" + pointSymbol
        }

    }
    @IBAction func Operation(sender: UIButton) {
        userTyping = false
        let number1 = displayScreen.text!
        firstNumber = Double(number1)!
        operation = sender.currentTitle!
        disableEquals = true
    }
  
    @IBAction func equals(sender: UIButton) {
        if disableEquals == false {
        
        if operation == "" {
            if userTyping == false {
            displayScreen.text = "0.0"
            } else {
                let number = displayScreen.text!
                displayScreen.text = number
            }
        } else {
            let number2 = displayScreen.text!
            secondNumber = Double(number2)!
            if operation == "+" {
                result = firstNumber + secondNumber
            } else if operation == "-" {
                result = firstNumber - secondNumber
            } else if operation == "×" {
                result = firstNumber * secondNumber
            } else if operation == "÷" {
                result = firstNumber / secondNumber
            } else if operation == "% " {
                result = (firstNumber/100) * secondNumber
            } else if operation == "ʸ√x" {
                result = pow(firstNumber,(1/secondNumber))
            } else {
                result = pow(firstNumber, secondNumber)
            }
            displayScreen.text = "\(result)"
        }
        userTyping = true
        disableEquals = true
        disableFactorial = false
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        displayScreen.text = "0.0"
        userTyping = false
    }
    
    @IBAction func backSpace(sender: UIButton) {
        
        let truncated = String(displayScreen.text!.characters.dropLast())
        displayScreen.text = truncated
        userTyping = true
    }
    
    @IBAction func eRaisetoA(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        result = pow(2.71828, firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
    }
    @IBAction func squareRoot(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        result = sqrt(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
        
    }
    
    @IBAction func pi(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        if userTyping == false {
            displayScreen.text = "\(pi)"
        } else {
            result = firstNumber * pi
            displayScreen.text = "\(result)"
        }
        disableEquals = true
    }
   
    
    @IBAction func Factorial(sender: UIButton) {
        if disableFactorial == false {
            let number = displayScreen.text!
            firstNumber = Double(number)!
            result = factorial(firstNumber)
            displayScreen.text = "\(result)"
            disableEquals = true
        }
    }
    
    func factorial(n: Double) -> Double {
        if n >= 0 {
            return n == 0 ? 1 : n * self.factorial(n - 1)
        } else {
            userTyping = false
            return 0 / 0
        }
    }
    
    @IBAction func Log10(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        result = log10(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
    }
    @IBAction func Ln(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        result = log(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
    }
    @IBAction func random(sender: UIButton) {
        let number = drand48()
        displayScreen.text = "\(number)"
    }
    @IBAction func oneByX(sender: UIButton) {
        let number = displayScreen.text!
        firstNumber = Double(number)!
        result = 1/firstNumber
        displayScreen.text = "\(result)"
        disableEquals = true
    }
}


