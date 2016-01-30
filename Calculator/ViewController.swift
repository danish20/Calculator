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
    
    var NoDecimalYet = true
    var disableTapping = true
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
    
    
    func limitLabelLength() {
        if self.displayScreen.text?.characters.count > 11 {
            let index = displayScreen.text?.startIndex.advancedBy(11)
            self.displayScreen.text = self.displayScreen.text?.substringToIndex(index!)
        }
    }
    
    func formatLabel() {
        var string = displayScreen.text!
        let length = string.characters.count
        let char = "," as Character
        if length == 4 {
            string.insert(char, atIndex: (string.startIndex.advancedBy(1)))
        } else if length == 6 {
            string.removeAtIndex(string.startIndex.advancedBy(1))
            string.insert(char, atIndex: (string.startIndex.advancedBy(2)))
        } else if length == 7 {
            string.removeAtIndex(string.startIndex.advancedBy(2))
            string.insert(char, atIndex: (string.startIndex.advancedBy(3)))
        } else if length == 8 {
            string.removeAtIndex(string.startIndex.advancedBy(3))
            string.insert(char, atIndex: (string.startIndex.advancedBy(1)))
            string.insert(char, atIndex: (string.startIndex.advancedBy(5)))
        } else if length == 10 {
            string.removeAtIndex(string.startIndex.advancedBy(1))
            string.insert(char, atIndex: (string.startIndex.advancedBy(2)))
            string.removeAtIndex(string.startIndex.advancedBy(5))
            string.insert(char, atIndex: (string.startIndex.advancedBy(6)))
        } else if length == 11 {
            string.removeAtIndex(string.startIndex.advancedBy(2))
            string.insert(char, atIndex: (string.startIndex.advancedBy(3)))
            string.removeAtIndex(string.startIndex.advancedBy(6))
            string.insert(char, atIndex: (string.startIndex.advancedBy(7)))
            disableTapping = false
        }
        displayScreen.text = string
    }
    
    func Numberfirst() {
        let number = displayScreen.text!
        let number1 = number.stringByReplacingOccurrencesOfString(",", withString: "")
        firstNumber = Double(number1)!
    }
    
    func Numbersecond() {
        let number = displayScreen.text!
        let number2 = number.stringByReplacingOccurrencesOfString(",", withString: "")
        secondNumber = Double(number2)!
    }
    
    func resultFormatting() {
        displayScreen.text = "\(result)"
        let substr = displayScreen.text?.substringFromIndex(displayScreen.text!.endIndex.advancedBy(-2))
        if substr == ".0" {
            displayScreen.text = displayScreen.text?.substringToIndex(displayScreen.text!.endIndex.advancedBy(-2))
        }
    
        
//        if let idx = displayScreen.text?.characters.indexOf(".")  {
//            displayScreen.text = displayScreen.text?.substringToIndex(displayScreen.text!.startIndex.advancedBy(11))
            //let pos = displayScreen.text?.startIndex.distanceTo(idx)
            
        //}
        
      //  if pos == 1 || pos == 2 || pos ==3 {
            
        //}
      
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
        if disableTapping == true {
        let digit = sender.currentTitle
        if userTyping == true {
            displayScreen.text = displayScreen.text! + digit!
            limitLabelLength()
            if NoDecimalYet == true {
            formatLabel()
            }
        } else {
            displayScreen.text = digit
        }
        userTyping = true
        disableEquals = false
        disableFactorial = false
        }
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
         NoDecimalYet = false
    }
    
    @IBAction func Operation(sender: UIButton) {
        userTyping = false
        disableTapping = true
        Numberfirst()
        operation = sender.currentTitle!
        disableEquals = true
        NoDecimalYet = true
    }
  
    @IBAction func equals(sender: UIButton) {
        if disableEquals == false {
        
        if operation == "" {
            if userTyping == false {
            displayScreen.text = "0"
            } else {
                let number = displayScreen.text!
                displayScreen.text = number
            }
        } else {
            Numbersecond()
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
           // displayScreen.text = "\(result)"
            resultFormatting()
        }
        userTyping = false
        disableEquals = true
        disableFactorial = false
        disableTapping = true
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        displayScreen.text = "0"
        userTyping = false
        NoDecimalYet = true
    }
    
    @IBAction func backSpace(sender: UIButton) {
         if displayScreen.text?.rangeOfString(".") != nil {
            NoDecimalYet = false
         } else {
            NoDecimalYet = true
        }
        var truncated = String(displayScreen.text!.characters.dropLast())
        let length = truncated.characters.count
        let char = "," as Character
       
        if NoDecimalYet == true {
        if length == 4 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(1))
        } else if length == 5 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(2))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(1))
        } else if length == 6 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
        } else if length == 8 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(1))
            truncated.removeAtIndex(truncated.startIndex.advancedBy(4))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(3))
        } else if length == 9 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(2))
            truncated.removeAtIndex(truncated.startIndex.advancedBy(5))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(1))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(5))
        } else if length == 9 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
            truncated.removeAtIndex(truncated.startIndex.advancedBy(5))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(5))
        } else if length == 10 {
            truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
            truncated.insert(char, atIndex: truncated.startIndex.advancedBy(6))
            truncated.removeAtIndex(truncated.startIndex.advancedBy(8))
            }
        }
        displayScreen.text = truncated
        userTyping = true
        disableTapping = true
    }
    
    @IBAction func eRaisetoA(sender: UIButton) {
        Numberfirst()
        result = pow(2.71828, firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
        userTyping = false
        NoDecimalYet = true
    }
    @IBAction func squareRoot(sender: UIButton) {
        Numberfirst()
        result = sqrt(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
        userTyping = false
        NoDecimalYet = true
    }
    
    @IBAction func pi(sender: UIButton) {
       Numberfirst()
        if userTyping == false {
            displayScreen.text = "\(pi)"
        } else {
            result = firstNumber * pi
            displayScreen.text = "\(result)"
        }
        disableEquals = true
        userTyping = false
    }
   
    
    @IBAction func Factorial(sender: UIButton) {
        if disableFactorial == false {
            Numberfirst()
            result = factorial(firstNumber)
            displayScreen.text = "\(result)"
            disableEquals = true
            userTyping = false
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
        Numberfirst()
        result = log10(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
        userTyping = false
        NoDecimalYet = true
    }
    @IBAction func Ln(sender: UIButton) {
        Numberfirst()
        result = log(firstNumber)
        displayScreen.text = "\(result)"
        disableEquals = true
        userTyping = false
        NoDecimalYet = true
    }
    @IBAction func random(sender: UIButton) {
        let number = drand48()
        displayScreen.text = "\(number)"
        userTyping = false
        NoDecimalYet = true
    }
    @IBAction func oneByX(sender: UIButton) {
        Numberfirst()
        result = 1/firstNumber
        displayScreen.text = "\(result)"
        disableEquals = true
        userTyping = false
        NoDecimalYet = true
    }
}


