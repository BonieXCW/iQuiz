//
//  ContentView.swift
//  iQuiz
//
//  Created by stlp on 5/15/24.
//

import SwiftUI
import Foundation

struct Category: Codable, Hashable {
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Codable, Hashable {
    let text: String
    let answer: String
    let answers: [String]
}

func getCategoriesContent(completion:@escaping ([Category]) -> ()) {
    guard let url = URL(string: "https://tednewardsandbox.site44.com/questions.json") else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        let Category = try! JSONDecoder().decode([Category].self, from: data!)
        
        DispatchQueue.main.async {
            completion(Category)
        }
    }
    .resume()
}

struct ContentView: View {
    
    @State private var hasFetchedCategories = false
    @State var categories: [Category] = []
    
    var body: some View {
        NavigationStack {
            List(categories, id: \.self) { category in
                NavigationLink(destination: QuizView(
                    currentIndex: 0,
                    numberOfCorrect: 0,
                    questions: category.questions)) {
                        HStack {
                            Image(systemName: "rectangle.stack")
                            
                            VStack(alignment: .leading) {
                                Text(category.title)
                                    .font(.title)
                                
                                Text(category.desc)
                                    .fontWeight(.light)
                            }
                        }
                    }
            }
            .onAppear {
                if !hasFetchedCategories {
                    getCategoriesContent { fetchedCategories in
                        self.categories = fetchedCategories
                        self.hasFetchedCategories = true
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingView(categories: $categories)) {
                        Text("Settings")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
