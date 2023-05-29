//
//  Tokenization.swift
//  Sapphire
//
//  Created by Surya kiran on 28/04/23.
//

import Foundation
class Tokenization{
    @Published private(set) var text:String
    @Published private(set) var tokens:[String]
    @Published private(set) var sentTokenized:[String]
    
    
    func tokenizeCorpus(_ inputString: String, delimiter: Character) -> [String] {
        return inputString.split(separator: delimiter).map { String($0) }
    }
     func sentTokenStrip(_ sentTokens:Array<String>)->Array<String>{
        var newArr:Array<String> = []
        sentTokens.forEach{sentToken in
            let newStr = sentToken.replacingOccurrences(of: ",",with:"").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: ";", with: "").replacingOccurrences(of: "/", with: "")
            newArr.append(newStr)
        }
        return newArr
    }
    func detectWordTokens(in sentTokens:Array<String>)->[String]{
        let attached = sentTokens.joined(separator: " ")
        print("attached is \(attached)")
        return tokenizeCorpus(attached,delimiter: " ")
    }
    func tokenizeTextIntoSentences(string: String, byDelimiter delimiter: String) -> [String] {
        return string.split(separator: delimiter).map { String($0) }
    }
    func tokenization()->[String]{
        sentTokenized = tokenizeTextIntoSentences(string:text,byDelimiter:".");
        sentTokenized = sentTokenStrip(sentTokenized)
        return detectWordTokens(in:sentTokenized)
    }
    init(corpus:String){
        text = String();
        text = corpus;
        tokens = Array<String>();
        sentTokenized = Array<String>();
        sentTokenized = tokenizeTextIntoSentences(string:text,byDelimiter:".");
        sentTokenized = sentTokenStrip(sentTokenized)
        tokens = detectWordTokens(in:sentTokenized)
    }
}
