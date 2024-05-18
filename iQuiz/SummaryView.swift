//
//  SummaryView.swift
//  iQuiz
//
//  Created by stlp on 5/17/24.
//

import SwiftUI

struct SummaryView: View {
    let numberOfCorrect: Int
    let questions: [Question]
    
    var body: some View {
        NavigationStack {
            VStack {
                let totalNumber = questions.count
                Text("You got \(numberOfCorrect) out of \(totalNumber) correct").padding()
                
                NavigationLink(destination: ContentView()) {
                    Text("Home")
                        .foregroundColor(.orange)
                        .padding()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

