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
            TextField("Enter VideoID", text: $inputText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding().frame(width: 200)
                        
            Text("You entered: \(inputText)")
                .padding()
        }
            VStack {
                if let model = viewModel.items {
                    
                    let finalScore = viewModel.sapphireEvaluation(of:model.txt)
                    Text(String(finalScore.score))
                } else {
                    Text("No transcription available")
                }
                
                Button("Fetch Data") {
                    viewModel.fetchData(of: inputText)
                    print(inputText)
                }
            }
            
        
    }
    struct MainContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainContentView()
        }
    }
    
}
