//
//  Sapphire.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//


import Foundation
import SwiftUI
class Transcription{
    @Published var transcript:String;
    private(set) var videoID:String;
    private(set) var api_key:String;
    @State private(set) var items = Model(txt:"");
      func fetchData() {
        let api = "http://127.0.0.1:5000"
        guard let url = URL(string: api) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          do {
             if let data = data {
               let result = try JSONDecoder().decode(Model.self, from: data)
               DispatchQueue.main.async {
                   self.items = result
                   print("result is ",result)
             }
             } else {
               print("No data")
             }
          } catch (let error) {
             print(error.localizedDescription)
          }
         }.resume()
      }
    
    init(VIDEOID:String,API_KEY:String){
        transcript = String();
        videoID = VIDEOID;
        api_key = API_KEY;
        fetchData();

    }
    struct Post:Codable{
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    struct Model: Decodable {
        let txt:String
    }
}
