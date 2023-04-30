//
//  ContentView.swift
//  Sapphire
//
//  Created by Surya kiran on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    let viewmodel:Viewmodel
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor).onTapGesture {
                    print(viewmodel.sentTokens,viewmodel.tokens)
                    
                }
            Text(viewmodel.transcript)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewmodel: Viewmodel())
    }
}
