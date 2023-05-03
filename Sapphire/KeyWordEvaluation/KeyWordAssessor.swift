//
//  KeyWordAssessor.swift
//  Sapphire
//
//  Created by Surya kiran on 02/05/23.
//

import Foundation
class KeyWordAssesor{
    @Published private var threshold:Double
    @Published private var keywords:Array<String>
    func averageScore(of stats:TFIDF.DATA)->Double{
        let sum = stats.tfidf.reduce(0, +)
        let length = stats.tfidf.count
        return Double(sum)/Double(length)
    }
    func qualify(_ stats:TFIDF.DATA){
        for i in 0...stats.tokens.count-1{
            if stats.tfidf[i]>=threshold{
                keywords.append(stats.tokens[i])
            }
        }
    
    }
    init(statistics:TFIDF.DATA){
        threshold = Double()
        keywords = Array<String>()
        threshold = averageScore(of:statistics)
        qualify(statistics)
        print("key words are",keywords)
    }
    
}
