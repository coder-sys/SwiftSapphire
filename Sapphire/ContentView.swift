//
//  ContentView.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewmodel:Viewmodel = Viewmodel(transcript: "hi world")
    @State var items:Model = Model(txt: "")
    @State var score:Double = Double(0.0)
    @State private var isLoading = false
    @State private var errorMessage = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor).onTapGesture {
                    viewmodel.fetchData()
                    print(viewmodel.EvaluateTranscript())

                }
        }
        .padding()
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
