//
//  SplashScreenView.swift
//  Sapphire
//
//  Created by Surya kiran on 29/05/23.
//

import SwiftUI

struct SapphireView: View {
    @State var viewState:String = "splash"
    @State private var size = 0.8;
    @State private var opacity = 0.5;
    var body: some View {
        if viewState == "splash"{
            SplashScreenView(size: size, opacity: opacity).onAppear{
                DispatchQueue.main.asyncAfter(deadline:.now()+2.0){
                    withAnimation{
                        self.viewState = "main"
                    }
                }
            }
        }
        else{
            MainContentView()
        }
    }
}

struct SapphireView_Previews: PreviewProvider {
    static var previews: some View {
        SapphireView()
    }
}
