//
//  CalculatorBrain.swift
//  L12Calculator
//
//  Created by zhanghl on 16/1/11.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import Foundation

class CalculatorBrain{
    enum Op :CustomStringConvertible{
        case Operand(Double)
        case UnarrayOperation(String,Double->Double)
        case BinarrayOperation(String,(Double,Double)->Double)
        
        var description:String{
            get{
                switch self{
                case .Operand(let _d):
                    return "\(_d)"
                case .UnarrayOperation(let symbol, _):
                    return "\(symbol)"
                case .BinarrayOperation(let symbol,_):
                    return "\(symbol)"
                }
               
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knowOp = Dictionary<String,Op>()
    
    init(){
        knowOp["+"] = Op.BinarrayOperation("+", + )
        knowOp["−"] = Op.BinarrayOperation("−") { $1 - $0 }
        knowOp["×"] = Op.BinarrayOperation("×", * )
        knowOp["÷"] = Op.BinarrayOperation("÷" ){ $1 / $0 }
        knowOp["√"] = Op.UnarrayOperation("√",sqrt )
    }
    
    
   private func execute(ops:[Op]) -> (result:Double?,remainderOps:[Op]){
        if !ops.isEmpty{
            var remainingOps = ops
           let op = remainingOps.removeLast()
            
            switch op{
                case .Operand(let operand):
                    return (operand,remainingOps)
                case .UnarrayOperation(_, let operation):
                    let operationResult = self.execute(remainingOps)
            
                    if let operand = operationResult.result {
                        return (operation(operand),operationResult.remainderOps)
                }
                
                case .BinarrayOperation(_, let opration):
                    let op1EexcuteVal = self.execute(remainingOps)
                    if let operand1 = op1EexcuteVal.result{
                        let op2ExecuteVal = self.execute(op1EexcuteVal.remainderOps)
                        if let operand2 = op2ExecuteVal.result{
                            return (opration(operand1,operand2),op2ExecuteVal.remainderOps)
                        }
                }
            }
        }
    
        return (nil,ops)
        
    }
    
    func execute()->Double?{
        let (result,remainder) = self.execute(opStack)
        print("\(opStack) =\(result) with \(remainder) left over")
        
        return result
    }
    
    func pushOperand(operand:Double)->Double?{
        opStack.append(Op.Operand(operand))
        return execute()
    }
    
    func performOperand(symbol:String) ->Double?{
//        opStack.append(ke)
        if let op = knowOp[symbol]{
            opStack.append(op)
        }
        return execute()
    }
    
}
