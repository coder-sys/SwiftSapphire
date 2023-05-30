//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var items: Transcription.Model?
    
    
    //MARK: -Intent(s)
    func fetchData(of videoID:String) {
        let transcription = Transcription(VIDEOID: videoID, API_KEY: "your_api_key")
        
        transcription.fetchData { [weak self] result in
            self?.items = result
        }
    }
    func sapphireEvaluation(of txt:String)->FinalScoreCalculator{
        let tokeniser:Tokenization = Tokenization(corpus: txt.lowercased())
        
        let sentTokenized = tokeniser.tokenizeTextIntoSentences(string:tokeniser.text,byDelimiter:".");
        
        let sentTokens = tokeniser.sentTokenStrip(sentTokenized)
        let tokens = tokeniser.detectWordTokens(in:sentTokens)
        let tfidf = TFIDF(tokens: tokens, sentTokens:sentTokens)
        let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
        let collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
        let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection)
        print(finalScore.score)
        return finalScore
    }
}
