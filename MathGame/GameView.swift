//
//  ContentView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-13.
//

import SwiftUI

enum Operator: String, CaseIterable {
    case add = "+"
    case substract = "-"
    case multiply = "*"
    case divide = "/"
}

struct GameView: View {
    
    // Variables
    @State private var lhs: Int = 0
    @State private var rhs: Int = 0
    @State private var opr: Operator = Operator.add
    @State private var answer: String = ""
    @State private var answerStatus: Bool = false
    @State private var accuracy: Bool = false
    @State private var errorAlert: Bool = false
    @State private var actualAnswer: Int = 0
    
    @AppStorage ("score") private var score: Int = 0
    @AppStorage ("selectedColor") private var selectedColor: String = CustomColor.Emerald.rawValue
    @AppStorage ("fontSize") private var fontSize: Double = 25.00
    
    var body: some View {
        VStack {
            ScrollView {
                
                Text("Guess the Answer!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(selectedColor))
                    .padding(.bottom, 30.0)
                
                Text("What is \(lhs) \(opr.rawValue) \(rhs)?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.bottom, 20.0)
                
                HStack {
                    TextField("Answer", text: $answer)
                    Button {
                        checkAnswer()
                    } label: {
                        Text("Submit")
                    }
                    .disabled(answerStatus)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
                .padding()
                .border(.gray)
                if (accuracy && answerStatus) {
                    Label("CORRECT ANSWER! WELL DONE", systemImage: "checkmark.circle.fill").foregroundColor(.green)
                } else if (!accuracy && answerStatus) {
                    Label("Incorrect answer! The actual answer is \(actualAnswer)", systemImage: "xmark.circle.fill").foregroundColor(.red)
                }
                
                Text("\(score)")
                    .font(.system(size: 100, weight: .heavy))
                    .padding(.vertical, 50.0)
                
                Text("Instructions \n\nSubmit the correct answer and gain 1 point. Submit the wrong answer or press \"NEXT\" you will lose one point")
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20.0)
                    .padding(.horizontal, 5.0)
                    .font(.system(size: fontSize))
                
                Button {
                    answer = ""
                    if (!accuracy) {
                        deductPoint()
                    }
                    accuracy = false
                    answerStatus = false
                    generateQuestion()
                } label: {
                    Text("Next")
                }
                .buttonStyle(.bordered)
                .tint(.green)
                .alert(isPresented: $errorAlert){
                    Alert(
                        title: Text("Cannot Submit Answer"),
                        message: Text("The answer must be given in Integers!"),
                        dismissButton: .cancel(Text("Okay"))
                    )
                }
            }
                
            
        }
        .onAppear{
            generateQuestion()
        }
        .padding()
    }
    
    // UNCOMMENT
    private func generateOperands() -> Int {
        let operandRange = 0..<10
        let randomOperand: Int? = operandRange.randomElement()
        return randomOperand ?? 1
    }
    
    // UNCOMMENT
    private func generateOperator() -> Operator {
        let randomOperator: Operator? = Operator.allCases.randomElement()
        return randomOperator ?? Operator.add
    }
    
    private func generateQuestion() {
        // Generate random question with 2 random operands and 1 operator using the above functions and show it to the user
        lhs = generateOperands()
        rhs = generateOperands()
        opr = generateOperator()
    
        switch opr{
        case Operator.add:
            actualAnswer = lhs + rhs
        case Operator.substract:
            actualAnswer = lhs - rhs
        case Operator.multiply:
            actualAnswer = lhs * rhs
        case Operator.divide:
            actualAnswer = lhs / rhs
        }
    }
    
    private func checkAnswer() {
        guard let doubleAnswer = Int(answer)
        else {
            errorAlert = true
            return
        }
        if (actualAnswer == doubleAnswer) {
            accuracy = true
            answerStatus = true
            addPoint()
        } else {
            accuracy = false
            answerStatus = true
            deductPoint()
        }
    }
    
    private func addPoint() {
        score+=1
    }
    
    private func deductPoint() {
        if (score > 0) {
            score-=1
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
