import Foundation
import SwiftUI

class Transcription: ObservableObject {
    @Published var transcript: String
    private(set) var videoID: String
    private(set) var api_key: String
    
    init(VIDEOID: String, API_KEY: String) {
        transcript = String()
        videoID = VIDEOID
        api_key = API_KEY
    }
    
    func fetchData(from query:String,completion: @escaping (Model?) -> Void) {
        let api = "http://127.0.0.1:5000/get_transcript/\(query)"
        guard let url = URL(string: api) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(Model.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("No data")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    struct Model: Decodable {
        let thumbnails: [String]
        let links: [String]
        let names: [String]
        let transcripts: [String]
        var scores: [Double]
    }
}
