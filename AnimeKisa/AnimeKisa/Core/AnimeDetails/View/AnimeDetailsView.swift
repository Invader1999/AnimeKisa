//
//  AnimeDetailsView.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//

import SwiftUI

struct AnimeDetailsView: View {
    @State var title:String
    @State var genres:[String] = ["Action","Adventure","Action","Isekai","Romance","Sports"]
    //@State var value1:String
    var body: some View {
        ScrollView{
            VStack{
                VStack {
                    HStack{
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 150,height: 200)
                        VStack(spacing:10){
                            Text(title)
                                .bold()
                                .frame(maxWidth: .infinity,alignment: .leading)
                            TopLabel(icon: "movieclapper.fill", value: "TV")
                            TopLabel(icon: "stopwatch", value: "25 Episodes")
                            TopLabel(icon: "dot.radiowaves.up.forward", value: "Airing")
                            TopLabel(icon: "star.fill", value: "7.76")
                                
                        }
                        .padding(.bottom,30)
                    }
                }
                .frame(maxHeight: .infinity,alignment: .top)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(genres,id:\.self) { genre in
                          Text(genre)
                                .padding(.horizontal,8)
                                .padding(.vertical,4)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(lineWidth: 1)
                                        
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollClipDisabled()
            }
            .padding(.leading)
        }
        
    }
}

#Preview {
    AnimeDetailsView(title: "Tsuki ga Michubiku Isekai Douchuu 2nd Season")
}

struct TopLabel:View {
    @State var icon:String
    @State var value:String
    var body: some View {
        HStack{
            Image(systemName: icon)
            Text(value)
        } 
        .frame(maxWidth: .infinity,alignment: .leading)
        
    }
}

struct GenreTile: View {
    @State var genre:String
    var body: some View {
        Text(genre)
    }
}


