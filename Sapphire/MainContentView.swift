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
    var body: some View {
        VStack{
            TextField("Enter your search", text: $inputText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding().frame(width: 250)
                        
            Text("You entered: \(inputText)")
                .padding()
        }
            VStack {
                if var model = viewModel.items {
                    
                    if inputText != ""{
                        Text(String(viewModel.addScore(to:&model).scores[0]))
                        Text(String(viewModel.addScore(to:&model).names[0]))
                        
                        Text(String(viewModel.addScore(to:&model).scores[1]))
                        Text(String(viewModel.addScore(to:&model).names[1]))
                        
                        Text(String(viewModel.addScore(to:&model).scores[2]))
                        Text(String(viewModel.addScore(to:&model).names[2]))
                    }
                } else {
                    Text("No transcription available")
                    VideoCardView(imageName:"https://i.ytimg.com/vi/8mAITcNt710/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDbl5Ssz7QqYHagWcDXvWFKUpogOQ",name: "Harvard CS50 – Full Computer Science University Course", link: "https://www.youtube.com/watch?v=8mAITcNt710")
                }
                Button("Get info and ranking") {
                    viewModel.fetchData(of: inputText,and: inputText)
                    inputText = ""
                }
            }
            
        
    }
    struct MainContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainContentView()
        }
    }
    
}
