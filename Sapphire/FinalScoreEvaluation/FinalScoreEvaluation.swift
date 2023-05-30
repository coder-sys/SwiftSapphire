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
    
    func numeratorEvaluation(using statistics:TFIDF.DATA){
        for index in 0...statistics.tokens.count-1{
            num += statistics.tfidf[index]*statistics.distrib[index]
        }
    }
    init(statistics:TFIDF.DATA){
        num = Double()
        score = Double()
        numeratorEvaluation(using: statistics)
        score = num
        
    }
}
