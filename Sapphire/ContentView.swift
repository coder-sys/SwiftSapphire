//
//  ContentView.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewmodel:Viewmodel = Viewmodel(transccript: "hello world")
    @State var items:Model = Model(txt: "")
    @State var score:Double = Double(0.0)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor).onTapGesture {
                    print(viewmodel.EvaluateTranscript())

                }
        }
        .padding()
        Text(items.txt).onAppear{
            fetchData()
        }
    }
    func fetchData() {
      let api = "http://127.0.0.1:5000"
      guard let url = URL(string: api) else { return }
        
        
      URLSession.shared.dataTask(with: url) { (data, response, error) in
        do {
           if let data = data {
             let result = try JSONDecoder().decode(Model.self, from: data)
             DispatchQueue.main.async {
                 self.items = result
                 
           }
           } else {
             print("No data")
           }
        } catch (let error) {
           print(error.localizedDescription)
        }
       }.resume()
    }
    
    struct Model: Decodable {
        let txt:String
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
