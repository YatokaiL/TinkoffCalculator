//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by Yato on 02.02.2024.
//  Copyright © 2024 Kirill Prilepskij. All rights reserved.
//

import UIKit

enum CaluclationError: Error {
    case divideByZero
}

enum Operation: String {
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "/"
    
    func calculate(_ number1:Double,_ number2:Double) throws -> Double {
        switch self {
        case .add:
            return number1 + number2
            
        case .substract:
            return number1 - number2
            
        case .multiply:
            return number1 * number2
            
        case .divide:
            if number2 == 0{
                throw CaluclationError.divideByZero
            }
            return number1 / number2
        
        }
    }
}

enum CalculationHistoryItem {
    case number(Double)
    case operation(Operation)
}


class ViewController: UIViewController {

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else {return }
        
        if buttonText == "," && label.text?.contains(",") == true {
            return
        }
        
        if label.text == "0" {
            if buttonText == "," {
            
                label.text?.append(buttonText)
            }
            else {
                label.text = buttonText
                
            }
        }
        else {
            
            label.text?.append(buttonText)
        }
        
        
        
        
    }
    
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard
            let buttonText = sender.currentTitle,
            let buttonOperation = Operation(rawValue: buttonText)
            else {return}
        
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
            else {return}
        
        calculationHistory.append(.number(labelNumber))
        calculationHistory.append(.operation(buttonOperation))
        
        resetLabelText()
    }
    
    @IBAction func clearButtonPressed() {
        calculationHistory.removeAll()
        
        resetLabelText()
        
    }
    
    @IBAction func calculateButtonPressed() {
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
            else {return}
       
        calculationHistory.append(.number(labelNumber))
        
        do {
            let result = try calculate()
        
            label.text = numberFormatter.string(from: NSNumber(value: result))
        } catch {
            label.text = "Error"
        }
        
        calculationHistory.removeAll()
        
    }
    
    
    
    @IBOutlet weak var label: UILabel!
    
    var calculationHistory: [CalculationHistoryItem] = []
    
    lazy var numberFormatter :NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        resetLabelText()
        
    }
    
    func calculate() throws -> Double {
        guard case .number(let firstNumber)  = calculationHistory[0] else {return 0 }
        
        var currentResult = firstNumber
        
        for index in stride(from: 1, to: calculationHistory.count - 1 , by: 2)
        {
            guard
                case .operation(let operation) = calculationHistory[index],
                case .number(let number) = calculationHistory[index + 1]
                else {break}
            
            currentResult = try operation.calculate(currentResult, number)
        }
        
        return currentResult
    }
    
    func resetLabelText(){
        label.text = "0"
    }
    
    


}

