//
//  TFIDF.swift
//  Sapphire
//
//  Created by Surya kiran on 30/04/23.
//

import Foundation
class TFIDF{
    @Published private(set) var tf:Array<Double>
    @Published private(set) var idf:Array<Double>
    @Published private(set) var words:Array<String>
    @Published private(set) var collection:DATA
    func termFrequency(token: String, document: [String]) -> Double {
       // let termCount = document.filter { $0 == token }.count
       // let totalTerms = document.count
        let join = document.joined(separator: " ")
        let split = join.components(separatedBy: " ")
        let termCount = split.filter { $0 == token }.count
        return Double(termCount) / Double(split.count)
    }
    
    func idfScore(token: String, corpus: [String]) -> Double {
        let documentFrequency = corpus.filter { $0.contains(token) }.count
        let inverseDocumentFrequency = log(Double(corpus.count) / Double(documentFrequency))
        return inverseDocumentFrequency
    }
    func scoreMultiplier(tf:[Double],idf:[Double])->[Double]{
        assert(tf.count == idf.count, "Arrays must have the same length")
        var tfidf: [Double] = []
        for i in 0..<tf.count {
            tfidf.append(tf[i] * idf[i])
        }
        return tfidf
    }
    init(tokens:Array<String>,sentTokens:Array<String>){
        tf = Array<Double>()
        idf = Array<Double>()
        words = Array<String>()
        collection = DATA(tokens:[String()],tf:[Double()],idf:[Double()],tfidf:[Double(4)])
        let filtered = tokens.filter { !stopwords.contains($0.lowercased()) }
        for token in filtered{

            let termFreq = termFrequency(token:token,document: sentTokens)
            let inverseDocFreq = idfScore(token:token,corpus: sentTokens)
            tf.append(termFreq)
            idf.append(inverseDocFreq)
            words.append(token)
        }
        collection = DATA(tokens:words,tf:tf,idf:idf,tfidf:scoreMultiplier(tf: tf, idf: idf))
    }
    struct DATA{
        var tokens:Array<String>
        var tf:Array<Double>
        var idf:Array<Double>
        var tfidf:Array<Double>
        
    }
}
