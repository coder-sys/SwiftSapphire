//
//  VideoCardView.swift
//  Sapphire
//
//  Created by Surya kiran on 31/05/23.
//

import SwiftUI

struct VideoCardView: View {
    @State  var imageName: String
    @State  var name: String
    @State  var link: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).strokeBorder(Color.black, lineWidth: 2)
                .frame(width: 400, height: 50)
            
            HStack{
                AsyncImage(url: URL(string: imageName)){ image in
                    image.resizable().aspectRatio( contentMode: .fill)
                        
                } placeholder: {
                    Color.black
                }.frame(width: 20,height: 20)
                Link(destination: URL(string:link)!){
                    Text(name).frame(height: 25)
                }
                
            }
            
        }
    }
    }

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCardView(imageName:"",name: "", link: "")
    }
}
