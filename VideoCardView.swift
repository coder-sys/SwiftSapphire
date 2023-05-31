//
//  VideoCardView.swift
//  Sapphire
//
//  Created by Surya kiran on 31/05/23.
//

import SwiftUI

struct VideoCardView: View {
    @State  var imageName: String
    @State  var image: Image? = nil
    @State  var name: String
    @State  var link: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).strokeBorder(Color.black, lineWidth: 2)
                .frame(width: 250, height: 50)
            HStack{
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 20,height: 20)
                .padding()
                Link(name, destination: URL(string:link)!)
                
            }
            
        }.onAppear {
            loadImageFromURL()
        }
    }
    func loadImageFromURL() {
            guard let url = URL(string: imageName),
                  let data = try? Data(contentsOf: url),
                  let uiImage = UIImage(data: data) else {
                return
            }
            
            image = Image(uiImage: uiImage)
        }
}

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCardView(imageName:"",name: "", link: "")
    }
}
