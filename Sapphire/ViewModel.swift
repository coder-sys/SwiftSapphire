//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class Viewmodel:ObservableObject{
    private var model:Transcription = Transcription(VIDEOID:"bqu6BquVi2M",API_KEY:"API_KEY")
    
    private var tokeniser:Tokenization = Tokenization(corpus: "Deep neural networks, or deep learning networks, have several hidden layers with millions of artificial neurons linked together. A number, called weight, represents the connections between one node and another. The weight is a positive number if one node excites another, or negative if one node suppresses the other. Nodes with higher weight values have more influence on the other nodes.Theoretically, deep neural networks can map any input type to any output type. However, they also need much more training as compared to other machine learning methods. They need millions of examples of training data rather than perhaps the hundreds or thousands that a simpler network might need.".lowercased())
    
    var transcript:String {
        return model.transcript;
    }
    var items:Array<Transcription.Model>{
        return model.items
    }
    var tokens:Array<String>{
        return tokeniser.tokens
    }
    var sentTokens:Array<String>{
        return tokeniser.sentTokenized
    }
    // MARK: - Instent(s)
  
    func tokenizeTextIntoSentences(text:String) -> Array<String>{
        tokeniser.tokenizeTextIntoSentences(string:text,byDelimiter:".")
    }
    func createTFIDFEvaluator()->TFIDF.DATA{
        let tfidf = TFIDF(tokens: tokens, sentTokens: sentTokens)
        let assessor:KeyWordAssesor = KeyWordAssesor(statistics:tfidf.collection)
        var collection:TFIDF.DATA = assessor.eliminateIteration(in: tfidf.collection)
        collection = assessor.qualify(collection)
        print(collection.distrib.count,collection.tfidf.count,collection.tokens.count)
        return collection
    }
    
}
