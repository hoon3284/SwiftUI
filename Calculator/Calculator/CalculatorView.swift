//
//  ContentView.swift
//  Calculator
//
//  Created by wickedRun on 2021/05/20.
//

import SwiftUI

struct CalculatorView: View {
    @State private var userIsInTheMiddleOfTyping = false
    @State private var display = "0"
    @State private var brain = CalculatorBrain()
    
    let data = [["AC", "±", "%", "÷"],
                ["π", "cos", "√", "e"],
                ["7", "8", "9", "×"],
                ["4", "5", "6", "-"],
                ["1", "2", "3", "+"],
                ["0", ".", "="]]
    // cos, pi, root 등등 추가바람.
    
    var body: some View {
        let margin: CGFloat = 10
        return VStack {
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Text(display)
                        .foregroundColor(Color(red: 231/255, green: 76/255, blue: 60/255))
                        .font(.largeTitle)
                        .frame(height: 120)
                }.padding()
            }.padding(margin)
            
            VStack(spacing: margin) {
                ForEach(data, id: \.description) { items in
                    HStack(spacing: margin) {
                        ForEach(items, id: \.description) { item in
                            Text(item)
                                .font(.title)
                                .bold()
                                .foregroundColor(.blue)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity)
                                .background(Color(red: 234 / 255, green: 240 / 255, blue: 241 / 255))
                                .onTapGesture {
                                    touchAction(item)
                                }
                        }
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity)
    }
    
    private func touchAction(_ symbol: String) {
        if Int(symbol) != nil || symbol == "." {
            touchDigit(symbol)
        } else {
            performOperation(symbol)
        }
    }
    
    private func touchDigit(_ digit: String) {
        print(#function, digit)
        if userIsInTheMiddleOfTyping {
            display += digit
        } else {
            display = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private func performOperation(_ symbol: String) {
        print(#function, symbol)
        if userIsInTheMiddleOfTyping {
            brain.setOperand(Double(display)!)
            userIsInTheMiddleOfTyping = false
        }
        
        brain.performOperation(symbol)
        
        if let result = brain.result {
            display = String(result)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
