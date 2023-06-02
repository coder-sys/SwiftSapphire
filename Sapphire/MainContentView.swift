//
//  ContentView.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import SwiftUI

struct MainContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var inputText: String = ""
    @State private var refreshFlag = false
    
    @SceneStorage("isAppActive") var isAppActive = false
    
    var body: some View {
        VStack {
            TextField("Enter your search", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            
            Text("You entered: \(inputText)")
            
            VStack {
                if var model = viewModel.items {
                    let result = viewModel.addScore(to: &model)
                    
                    ForEach(0..<result.scores.count, id: \.self) { index in
                        Text(String(result.scores[index]))
                        Text(String(result.names[index]))
                    }

                    
                    // Refresh app here
                } else {
                    Text("No transcription available")
                }
            }

        }
        .onAppear {
            if isAppActive {
                // App was reopened, perform any necessary actions
                
                // Refresh the view
                DispatchQueue.main.async {
                    refreshFlag.toggle()
                }
                
                // Reset the flag
                isAppActive = false
            }
        }
        .onChange(of: refreshFlag) { _ in
            if let _ = viewModel.items {
                // Perform any additional logic or updates to the view model
                
                // Refresh the view
                DispatchQueue.main.async {
                    refreshFlag.toggle()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // App is about to resign active, store the state
            isAppActive = true
        }
        Button("Get info and ranking") {
            viewModel.fetchData(of: inputText, and: inputText)
            inputText = ""

        }
    }
}
