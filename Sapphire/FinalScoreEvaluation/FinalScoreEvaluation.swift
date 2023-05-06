//
//  FinalSquareCalculator.swift
//  Sapphire
//
//  Created by Surya kiran on 05/05/23.
//

import Foundation
class FinalSquareCalculator{
    @Published private(set) var score:Double
    private var num:Double
    private var den:Double
    func numeratorEvaluation(using statistics:TFIDF.DATA){
        for i in 0...statistics.tokens.count-1{
            num += statistics.tfidf[i]
        }
    }
    init(statistics:TFIDF.DATA){
        score = Double()
        num = Double()
        den = Double()
    }
}
