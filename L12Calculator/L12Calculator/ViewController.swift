//
//  ViewController.swift
//  L12Calculator
//
//  Created by zhanghl on 16/1/7.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var isReadyInput:Bool = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDiget(sender: UIButton) {
        let digit = sender.currentTitle!
        if isReadyInput{
            display.text = display.text! + digit
        }else{
            display.text = digit
            isReadyInput=true
        }
        print("digit = \(digit)")
    }

    @IBAction func oprator(sender: UIButton) {
      
        if isReadyInput{
            enter()
        }
        
        
        if let opratorText = sender.currentTitle {
            if let result = brain.performOperand(opratorText){
                displayValue = result
            }else{
                displayValue = 0
            }
            
            
        }
        /*
        switch opratorText{
            case "×": operationOperator{$0 * $1}
            case "÷": operationOperator{$1 / $0}
            case "+": operationOperator{$0 + $1}
            case "−": operationOperator{$1 - $0}
            case "√": oneOperationOperator{sqrt($0)}
            default: break
        }*/
        
    }
    
    func operationOperator(operation:(Double,Double)->Double){
        if operateStack.count>=2{
            displayValue = operation(operateStack.removeLast(),operateStack.removeLast())
            enter()
        }
    }
    
    func oneOperationOperator(operation:Double->Double){
        if operateStack.count>=1{
            displayValue = operation(operateStack.removeLast())
            enter()
        }
    }
    
    var operateStack = Array<Double>()
    
    @IBAction func enter() {
        isReadyInput=false
//        operateStack.append(displayValue)
        brain.pushOperand(displayValue)
        print("push:\(displayValue)")
    }
    
    var displayValue:Double{
        set{
            display.text = "\(newValue)"
            isReadyInput = false
        }
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
    }
}

