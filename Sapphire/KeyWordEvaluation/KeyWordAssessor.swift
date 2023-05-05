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
    func eliminateIteration(in statistics:TFIDF.DATA)->TFIDF.DATA{
        let copyTokens = statistics.tokens
        var copyTokens1:[String] = [copyTokens[0]]
        var copyTF1:[Double] = [statistics.tf[0]]
        var copyIDF1:[Double] = [statistics.idf[0]]
        var copyTFIDF1:[Double] = [statistics.tfidf[0]]
        var temp:Array<String> = [copyTokens[0]]
        for i in 0...copyTokens.count-2{
            temp.append(copyTokens[i])
            if temp.contains(copyTokens[i+1]){
                continue
            }
            else{
                copyTokens1.append(copyTokens[i+1])
                copyTF1.append(statistics.tf[i+1])
                copyIDF1.append(statistics.idf[i+1])
                copyTFIDF1.append(statistics.tfidf[i+1])
            }
        }
        print(copyTokens1.count,copyTFIDF1.count,copyTF1.count,copyIDF1.count)
        print("correct is",copyTokens1)
        return TFIDF.DATA(tokens:copyTokens1,tf:copyTF1,idf:copyIDF1,tfidf:copyTFIDF1)
    }
    init(statistics:TFIDF.DATA){
        threshold = Double()
        keywords = Array<String>()
        
        threshold = averageScore(of:statistics)
        qualify(statistics)
    }
    
}
