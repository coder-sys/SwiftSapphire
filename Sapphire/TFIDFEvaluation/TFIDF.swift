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
    @Published private(set)  var distrib:Array<Double>
    @Published private(set) var collection:DATA
    func termFrequency(token: String, document: [String]) -> [Double] {
        var termCount = 0
        var totalTerms = 0

        for term in document {
            if term == token {
                termCount += 1
            }
            totalTerms += 1
        }
        return [Double(1.0),Double(1.0)]
        //return [Double(termCount), Double(termCount) / Double(totalTerms)]
    }

    
    func idfScore(token: String, corpus: [String]) -> Double {
        let corpusSet = Set(corpus)
        let documentFrequency = corpusSet.contains(token) ? 1 : 0
        let additiveSmoothing = 1.0 // Additive smoothing value
        let inverseDocumentFrequency = log((Double(corpus.count) + additiveSmoothing) / (Double(documentFrequency) + additiveSmoothing))
        return inverseDocumentFrequency
    }


    func scoreMultiplier(tf: [Double], idf: [Double]) -> [Double] {
        assert(tf.count == idf.count, "Arrays must have the same length")

        var tfidf = [Double](repeating: 0.0, count: tf.count)

        for i in tf.indices {
            tfidf[i] = tf[i] * idf[i]
        }

        return tfidf
    }
    func createCollection(with tokens:Array<String>, and sentTokens:Array<String>)->DATA{
        let filtered = tokens.filter { !stopwords.contains($0.lowercased()) }
        for token in filtered{

            let termFreq = termFrequency(token:token,document: sentTokens)
            let inverseDocFreq = idfScore(token:token,corpus: sentTokens)
            tf.append(termFreq[1])
            idf.append(inverseDocFreq)
            words.append(token)
            distrib.append(termFreq[0])
        }
        collection = DATA(tokens:words,tf:tf,idf:idf,tfidf:scoreMultiplier(tf: tf, idf: idf),distrib:distrib)
        return collection
    }
    init(){
        tf = Array<Double>()
        idf = Array<Double>()
        words = Array<String>()
        distrib = Array<Double>()
        collection = DATA(tokens:[String()],tf:[Double()],idf:[Double()],tfidf:[Double(0)],distrib: [Double(0)])
        
    }
    struct DATA{
        var tokens:Array<String>
        var tf:Array<Double>
        var idf:Array<Double>
        var tfidf:Array<Double>
        var distrib:Array<Double>
    }
}
