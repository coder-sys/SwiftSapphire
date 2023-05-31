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
                    
                   // let finalScore = viewModel.sapphireEvaluation(of:String(model))
                   //     Text(String(finalScore.score))
                    Text(String(viewModel.addScore(to:&model).scores[0]))
                        
                    
                } else {
                    Text("No transcription available")
                }
                Button("Get info and ranking") {
                    viewModel.fetchData(of: inputText,and: inputText)
                }
            }
            
        
    }
    struct MainContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainContentView()
        }
    }
    
}
