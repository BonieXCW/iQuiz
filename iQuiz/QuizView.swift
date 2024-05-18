//
//  QuizView.swift
//  iQuiz
//
//  Created by stlp on 5/16/24.
//

import SwiftUI

struct QuizView: View {
    
    let questions: [Question]
    let currentIndex: Int
    let numberOfCorrect: Int
    @State var selectIndex = -1
    
    init(currentIndex: Int, numberOfCorrect: Int, questions: [Question]) {
        self.questions = questions
        self.numberOfCorrect = numberOfCorrect
        self.currentIndex = currentIndex
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(questions[currentIndex].text)
                
                ForEach(0..<questions[currentIndex].answers.count, id:\.self) { index in
                    HStack {
                        Button {
                            selectIndex = index
                        } label: {
                            if (selectIndex == index) {
                                Circle()
                                    .shadow(radius: 3)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue)
                            } else {
                                Circle()
                                    .stroke()
                                    .shadow(radius: 3)
                                    .frame(width: 24, height: 24)
                            }
                        }
                        Text(questions[currentIndex].answers[index])
                    }
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                
                NavigationLink(destination: AnswerView(
                    questions: questions,
                    selectedAnswerIndex: selectIndex,
                    currentIndex: currentIndex,
                    numberOfCorrect: numberOfCorrect
            
                        )) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(selectIndex == -1 ? Color.gray : Color.blue)
                            .cornerRadius(10)
                            .frame(width: 140, height: 40)
                }
            }
            .padding(.horizontal, 20)
            .frame(width: 320, height: 550, alignment: .leading)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(25)
            .shadow(radius: 10)
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

//#Preview {
//    QuizView()
//}
