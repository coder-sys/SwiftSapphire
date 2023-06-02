//
//  FinalSquareCalculator.swift
//  Sapphire
//
//  Created by Surya kiran on 05/05/23.
//

import Foundation
class FinalScoreCalculator{
    @Published private var num:Double
    @Published private(set) var score:Double
    
    func numeratorEvaluation(using statistics: TFIDF.DATA) {
        for index in stride(from: 0, to: statistics.tokens.count, by: 2) {
            num += statistics.tfidf[index] * statistics.distrib[index]
        }
    }


    init(statistics:TFIDF.DATA){
        num = Double()
        score = Double()
        numeratorEvaluation(using: statistics)
        score = num
        
    }
}
