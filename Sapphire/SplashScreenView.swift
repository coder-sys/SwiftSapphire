//
//  SplashScreenView.swift
//  Sapphire
//
//  Created by Surya kiran on 29/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var viewState:String
    @State private var size = 0.8;
    @State private var opacity = 0.5;
    var body: some View {
        if viewState == "splash"{
            VStack{
                VStack{
                    Image("sapphireLogo.jpg").resizable().cornerRadius(20).scaledToFill().frame(width: 128,height: 128)
                    Text("Sapphire").font(Font.custom("Baskerville-Bold",size: 26)).foregroundColor(.black.opacity(0.80))
                }.scaleEffect(size).opacity(opacity).onAppear{
                    withAnimation(.easeIn(duration: 1.1)){
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(viewState: "splash")
    }
}
