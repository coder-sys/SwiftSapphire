//
//  Tokenization.swift
//  Sapphire
//
//  Created by Surya kiran on 28/04/23.
//

import Foundation
class Tokenization{
    @Published var text:String
    @Published var tokens:[String]
    @Published var sentTokenized:[String]
    
    
    func tokenizeCorpus(text:String){
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            DispatchQueue.main.async {
                self.text = word
                self.tokens.append(word)
          }
            
            
        }
    
    }
     func sentTokenStrip(_ sentTokens:Array<String>)->Array<String>{
        var newArr:Array<String> = []
        sentTokens.forEach{sentToken in
            let newStr = sentToken.replacingOccurrences(of: ",",with:"").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: ";", with: "").replacingOccurrences(of: "/", with: "")
            newArr.append(newStr)
        }
        return newArr
    }
    func detectWordTokens(in sentTokens:Array<String>){
        let attached = sentTokens.joined(separator: " ")
        tokenizeCorpus(text:attached)
    }
    func tokenizeTextIntoSentences(string: String, byDelimiter delimiter: String) -> [String] {
        return string.split(separator: delimiter).map { String($0) }
    }

    init(corpus:String){
        text = String();
        text = corpus;
        tokens = Array<String>();
        sentTokenized = Array<String>();
        sentTokenized = tokenizeTextIntoSentences(string:text,byDelimiter:".");
        sentTokenized = sentTokenStrip(sentTokenized)
        detectWordTokens(in:sentTokenized)
    }
}
