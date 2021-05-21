//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by wickedRun on 2021/05/20.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unary(sqrt),
        "cos" : Operation.unary(cos),
        "±" : Operation.unary({ -$0 }),
        "×" : Operation.binary({ $0 * $1 }),
        "÷" : Operation.binary({ $0 / $1 }),
        "+" : Operation.binary({ $0 + $1 }),
        "-" : Operation.binary({ $0 - $1 }),
        "=" : Operation.equals,
        "%" : Operation.binary({ $0.truncatingRemainder(dividingBy: $1) }),
        "AC": Operation.constant(0)
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case.unary(let f):
                if accumulator != nil {
                    accumulator = f(accumulator!)
                }
            case.binary(let f):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: f, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        } else {
            print("Wrong operation symbol")
        }
    }
    
    mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
     }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
