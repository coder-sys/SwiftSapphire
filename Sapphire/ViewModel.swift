//
//  ViewModel.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var items: Transcription.Model?
    
    
    //MARK: -Intent(s)
    func fetchData(of videoID:String,and query:String) {
        let transcription = Transcription(VIDEOID: videoID, API_KEY: "your_api_key")
        
        transcription.fetchData(from:query) { [weak self] result in
            self?.items = result
        }
    }
    func sapphireEvaluation(of txt:String,using sentTokens:[String])->FinalScoreCalculator{
        let tokeniser:Tokenization = Tokenization(corpus: txt.lowercased())
        
        let sentTokenized = sentTokens
        
        let sentTokens = tokeniser.sentTokenStrip(sentTokenized)
        let tokens = tokeniser.detectWordTokens(in:sentTokens)
        let tfidf = TFIDF()
        let collection = tfidf.createCollection(with: tokens, and: sentTokens)
        let assessor:KeyWordAssesor = KeyWordAssesor(statistics:collection)
        let collection1:TFIDF.DATA = assessor.eliminateIteration(in: collection)
        let finalScore:FinalScoreCalculator = FinalScoreCalculator(statistics: collection1)
        print(finalScore.score)
        return finalScore
    }
    func sortModelByScoresDescending(_ model: Transcription.Model) -> Transcription.Model {
        let sortedIndices = model.scores.indices.sorted { model.scores[$0] > model.scores[$1] }
        let sortedThumbnails = sortedIndices.map { model.thumbnails[$0] }
        let sortedSentTokens = sortedIndices.map { model.sentTokens[$0] }

        let sortedLinks = sortedIndices.map { model.links[$0] }
        let sortedNames = sortedIndices.map { model.names[$0] }
        let sortedTranscripts = sortedIndices.map { model.transcripts[$0] }
        let sortedScores = sortedIndices.map { model.scores[$0] }

        return Transcription.Model(thumbnails: sortedThumbnails,sentTokens: sortedSentTokens , links: sortedLinks, names: sortedNames, transcripts: sortedTranscripts, scores: sortedScores)
    }

    func addScore(to model: inout Transcription.Model)->Transcription.Model {
        var scores: [Double] = []
        for (transcript,sentTokens) in zip(model.transcripts,model.sentTokens) {
            scores.append(sapphireEvaluation(of: transcript,using:sentTokens).score)
        }
        model.scores = scores
        return sortModelByScoresDescending(model)
    }
}
