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
                    
                    ForEach(0..<min(3, result.scores.count)) { index in
                        Text(String(result.scores[index]))
                        Text(result.names[index])
                    }
                } else {
                    Text("No transcription available")
                    VideoCardView(imageName: "https://i.ytimg.com/vi/8mAITcNt710/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDbl5Ssz7QqYHagWcDXvWFKUpogOQ", name: "Harvard CS50 – Full Computer Science University Course", link: "https://www.youtube.com/watch?v=8mAITcNt710")
                }
            }
        }
        .onAppear {
            if isAppActive {
                // App was reopened, perform any necessary actions
                if let _ = viewModel.items {
                    // Perform any additional logic or updates to the view model
                    
                    // Refresh the view
                    DispatchQueue.main.async {
                        refreshFlag = true
                        refreshFlag = false
                    }
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
                    refreshFlag = true
                    refreshFlag = false
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
