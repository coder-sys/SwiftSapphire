//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class Viewmodel:ObservableObject{
     private var model:Transcription = Transcription(VIDEOID:"bqu6BquVi2M",API_KEY:"API_KEY")
    
    private var tokeniser:Tokenization
    init(transccript:String){
        tokeniser = Tokenization(corpus: String(transccript).lowercased())
    }
    
    var transcript:String {
        return model.transcript;
    }
    
    
    var score:Double{
        return EvaluateTranscript()
    }
    
    var tokens:Array<String>{
        return tokeniser.tokens
    }
    var sentTokens:Array<String>{
        return tokeniser.sentTokenized
    }
    // MARK: - Instent(s)
    
    func EvaluateTranscript()->Double{
        
        let tfidf = TFIDF(tokens: tokens, sentTokens: sentTokens)
        let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
        var collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
        collection = assessor.qualify(collection)
        print(collection.distrib.count,collection.tfidf.count,collection.tokens.count)
        let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection)
        return finalScore.score
    }
    
    struct Model: Decodable {
        let txt: String
    }
}
