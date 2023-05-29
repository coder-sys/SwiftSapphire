//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var items: Transcription.Model?
    
    func fetchData() {
        let transcription = Transcription(VIDEOID: "your_video_id", API_KEY: "your_api_key")
        
        transcription.fetchData { [weak self] result in
            self?.items = result
        }
    }
}
//  func EvaluateTranscript()->Double{
//
//      var tokens:Array<String>{
//          return tokeniser.tokens
//      }
//      var sentTokens:Array<String>{
//          return tokeniser.sentTokenized
//      }
//      let tfidf = TFIDF(tokens: tokens, sentTokens: sentTokens)
//      let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
//      var collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
//      collection = assessor.qualify(collection)
//      print(collection.distrib.count,collection.tfidf.count,collection.tokens.count)
//      let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection)
//      return finalScore.score
//  }
