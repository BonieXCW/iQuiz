//
//  AnswerView.swift
//  iQuiz
//
//  Created by stlp on 5/16/24.
//

import SwiftUI

struct AnswerView: View {
    let questions: [Question]
    let selectedAnswerIndex: Int
    let currentIndex: Int
    var numberOfCorrect: Int
    
    var body: some View {
        let question = questions[currentIndex]
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(question.text)
                Text("Correct Answer: " + question.answers[Int(question.answer)!])
                    .padding()
                Text("Your Answer:")
                Text(question.answers[selectedAnswerIndex])
                    .padding()
                if selectedAnswerIndex + 1 == Int(question.answer) {
                    Text("Correct")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                }
                else {
                    Text("Wrong")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                }
                
                if(questions.count > currentIndex+1) {
                    NavigationLink(destination: QuizView(currentIndex: currentIndex + 1, numberOfCorrect: selectedAnswerIndex + 1 == Int(question.answer) ? numberOfCorrect + 1 : numberOfCorrect, questions: questions)) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                else {
                    NavigationLink(destination: SummaryView(numberOfCorrect: numberOfCorrect, questions: questions)) {
                        Text("Finish")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .frame(width: 320, height: 550, alignment: .leading)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(25)
            .shadow(radius: 10)
            .navigationBarTitle("Question \(currentIndex + 1)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "chevron.backward")
                        Text("Home")
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
