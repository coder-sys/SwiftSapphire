//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class Viewmodel:ObservableObject{
    private var model:Transcription = Transcription(VIDEOID:"bqu6BquVi2M",API_KEY:"AIzaSyA3ttDko3lrmOwDgpPDxV0rplPlnhZ_gc0")
    
    private var tokeniser:Tokenization = Tokenization(corpus: "All human beings are born free and equal in dignity and rights.They are endowed with reason and conscience and should act towards one another in a spirit of brotherhood.".lowercased())
    
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
}
