//
//  ContentView.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var viewState = "splash"
    var body: some View {
        if viewState == "splash"{
            SplashScreenView(viewState: viewState)

        }
        if viewState == "main"{
            VStack {
                if let txt = viewModel.items?.txt {
                    
                    let finalScore = viewModel.sapphireEvaluation(of:txt)
                    Text(String(finalScore.score))
                } else {
                    Text("No transcription available")
                }
                
                Button("Fetch Data") {
                    viewModel.fetchData()
                }
            }
            
        }
    }
    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    }
    
    //let tfidf = TFIDF(tokens: tokeniser.tokens, sentTokens: tokeniser.sentTokenized)
    //let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
    //var collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
    //let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection)
}
//struct ContentView_Previews: PreviewProvider {
//static var previews: some View {
//    ContentView()
//}
//}

//          var tokeniser:Tokenization = Tokenization(corpus: txt.lowercased())
//         let tfidf = TFIDF(tokens: tokeniser.tokens, sentTokens: tokeniser.sentTokenized)
//                let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
//                var collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
 //              collection = assessor.qualify(collection)
//               print(collection.distrib.count,collection.tfidf.count,collection.tokens.count)
  //             let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection)
