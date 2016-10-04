//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
// 
//Need to fix scientific notation feature

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var userEnteringNumber :Bool = false
    var currValue = "0"
    var prevValue = ""
    var prevOperation:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        print("Update me like one of those PCs")
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        currValue = content
        if ([Character](content.characters).count <= 7) {
            currValue = content
            resultLabel.text! = content
            
        } else {
            let seven = content.substring(to: content.index(content.startIndex, offsetBy: 7))
            currValue = seven
            resultLabel.text! = seven

            /*if (!currValue.characters.contains(".")) {
                let length = content.characters.count - 5
                let five = content.substring(to: content.index(content.startIndex, offsetBy: 5))
                resultLabel.text! = five + "e" + String(length) // have to change it to look like scientific notation
            }
            else {
                let seven = content.substring(to: content.index(content.startIndex, offsetBy: 7))
                resultLabel.text! = seven
            }*/
        }
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        //return Double(a) Double(operation) Double(b)
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        let digit: String = (sender.content)

        if(currValue == "0" || userEnteringNumber == false) {
            updateResultLabel(digit)
        } else if (currValue == "-0") {
            updateResultLabel("-" + digit)
        } else {
            updateResultLabel(currValue + digit)
        }
        userEnteringNumber = true
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        // Fill me in!
        
        let operationSelected = (sender.content)
        if (operationSelected == "+/-") {
            if(currValue[currValue.startIndex] == "-") {
                currValue.remove(at: currValue.startIndex);
                updateResultLabel(currValue)
            } else {
                updateResultLabel("-" + currValue)
            }
        } else if (operationSelected == "C") {
            updateResultLabel("0")
            prevOperation = ""
            prevValue = ""
            userEnteringNumber = false
        } else if (operationSelected == "%") {
            let result = Double(currValue)! * 0.01
            updateResultLabel(String(result))
        } else if (operationSelected == "=") {
            equate()
            prevOperation = ""
        } else if (operationSelected == "+") {
            if (prevOperation != "" && prevValue != "") {
                equate()
            }
            prevValue = currValue
            currValue = "0"
            prevOperation = operationSelected
        } else if (operationSelected == "-") {
            if (prevOperation != "" && prevValue != "") {
                equate()
            }
            prevValue = currValue
            currValue = "0"
            prevOperation = operationSelected
        } else if (operationSelected == "*") {
            if (prevOperation != "" && prevValue != "") {
                equate()
            }
            prevValue = currValue
            currValue = "0"
            prevOperation = operationSelected
        } else if (operationSelected == "/") {
            if (prevOperation != "" && prevValue != "") {
                equate()
            }
            prevValue = currValue
            currValue = "0"
            prevOperation = operationSelected
        }
        
        userEnteringNumber = false
        
    }
    
    @IBAction func equate() {
        self.userEnteringNumber = false
        self.performOperation(prevOperation)
    }
    
    
    func performOperation (_ operation:String) {
        if (prevOperation == "") {
            return
        }
        let a = Double(prevValue)!
        let b = Double(currValue)!
        
        switch operation {
            case "+":
                truncateCheck(a + b)
        case "-":
            truncateCheck(a - b)
        case "*":
            truncateCheck(a * b)
        case "/":
            if (b == 0) {
                print("Divide by 0 error")
            } else {
                truncateCheck(a / b)
            }
        default:
            print("ERROR")
        }
    }
    
    func truncateCheck(_ result:Double) {
        if (result.truncatingRemainder(dividingBy: 1) == 0) {
            var digits = [Character](String(result).characters)
            digits.remove(at: digits.count-1) //remove 0
            digits.remove(at: digits.count-1) //remove decimal
            updateResultLabel(String(digits)
)
        } else {
            updateResultLabel(String(result))
        }
    }

    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
       // Fill me in!
        let digit: String = (sender.content)
        
        if (userEnteringNumber == true) {
            if (digit == ".") {
                updateResultLabel(self.resultLabel.text! + ".")
            }
            else {
                updateResultLabel(self.resultLabel.text! + (digit as String))
            }
        }
        else {
            if (digit == ".") {
                updateResultLabel("0.")
            }
            else {
                updateResultLabel(digit as String)
            }
            userEnteringNumber = true
        }
        
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}
