//
//  SettingView.swift
//  iQuiz
//
//  Created by stlp on 5/16/24.
//

import SwiftUI

struct SettingView: View {
    
    @State private var showingURLAlert = false
    @State private var showingNetworkAlert = false
    @State private var showingOk = false
    @Binding var categories: [Category]
    @State var userURL: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter alternate URL source", text: $userURL)
                .padding(.all, 30)
                .multilineTextAlignment(.center)
            
            Button("Check Now") {
                getCategory(userURL: self.userURL)
            }
            .alert("Invalid URL", isPresented: $showingURLAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Network not available", isPresented: $showingNetworkAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Data source updated", isPresented: $showingOk) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    func getCategory(userURL: String) {
        guard let url = URL(string: userURL)
        else { 
            self.showingURLAlert = true
            return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data
            else {
                self.showingNetworkAlert = true
                return
            }
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                
                DispatchQueue.main.async {
                    self.categories = categories
                }
                self.showingOk = true
            } catch {
                print ("decode failed")
            }
        }
        .resume()
    }

}


#Preview {
    SettingView(categories: .constant([]))
}
