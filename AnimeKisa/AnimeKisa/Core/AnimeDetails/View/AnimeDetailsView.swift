//
//  AnimeDetailsView.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//

import Kingfisher
import SwiftUI

struct AnimeDetailsView: View {
    @State var title: String = ""
    @State var genres: [String] = ["Action", "Adventure", "Action", "Isekai", "Romance", "Sports"]
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @State var getAnime: Node
    // @State var value1:String
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        KFImage(URL(string: getAnime.mainPicture?.medium ?? ""))
                            .resizable()
                            .placeholder {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 120, height: 160)
                                    .foregroundColor(.blue.opacity(0.1))
                            }
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.leading)

                        VStack(spacing: 10) {
                            Text(getAnime.title ?? "")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TopLabel(icon: "movieclapper.fill", value: animeDetailsViewModel.animeDetails?.source ?? "No Data")
                            TopLabel(icon: "stopwatch", value: "\(animeDetailsViewModel.animeDetails?.numEpisodes ?? 0)")
                            TopLabel(icon: "dot.radiowaves.up.forward", value: animeDetailsViewModel.animeDetails?.status ?? "No Data")
                            TopLabel(icon: "star.fill", value: animeDetailsViewModel.animeDetails?.rating ?? "0.00")
                        }
                        .padding(.bottom, 30)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(animeDetailsViewModel.animeDetails?.genres ?? [], id: \.id) { genre in
                            Text(genre.name)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1)
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollClipDisabled()

                SynopsisView()
                    .environment(animeDetailsViewModel)
                
                StatsView()
                    .environment(animeDetailsViewModel)
                
                
            }
            .onDisappear {
                getAnime.id = nil
            }
            .task {
                Task {
                    try await animeDetailsViewModel.getRecommendationAnimeDetails(id: getAnime.id ?? 21)
                }
            }
            .padding(.leading)
        }
    }
    
}

#Preview {
    AnimeDetailsView(title: "Tsuki ga Michubiku Isekai Douchuu 2nd Season", getAnime: Node(id: 21, title: "", mainPicture: MainPicture(medium: "", large: "")))
        .environment(AnimeDetailsViewModel())
}

struct TopLabel: View {
    @State var icon: String
    @State var value: String
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(value)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct GenreTile: View {
    @State var genre: String
    var body: some View {
        Text(genre)
    }
}

struct SynopsisView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @State var showFullText:Bool = false
    var body: some View {
        VStack {
            if let animeDetails = animeDetailsViewModel.animeDetails?.synopsis {
                Text(animeDetails)
                    .lineLimit(showFullText ? 20 : 5)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            Image(systemName: showFullText ? "chevron.up" : "chevron.down")
                .onTapGesture {
                    withAnimation(.spring) {
                        showFullText.toggle()
                    }
                }
                .padding(.top)
        }
    }
}

struct StatsView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    var body: some View {
        VStack(spacing:10){
            Text("Stats")
                .frame(maxWidth: .infinity,alignment: .leading)
                .bold()
            HStack(spacing:15){
                if let animeDetails = animeDetailsViewModel.animeDetails{
                    StatsIcons(label: "chart.bar.fill", value: "#\(animeDetails.rank ?? 0)")
                        
                    Divider()
                        .foregroundStyle(.black)
                    
                    StatsIcons(label: "hand.thumbsup.fill", value: "\(animeDetails.numScoringUsers ?? 0)")
                    
                    Divider()
                        .foregroundStyle(.black)
                    
                    StatsIcons(label: "person.2.fill", value: "\(animeDetails.numListUsers ?? 0)")
                    
                    Divider()
                        .foregroundStyle(.black)
                    
                    StatsIcons(label: "bolt.horizontal.fill", value: "\(animeDetails.popularity ?? 0)")
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

struct StatsIcons: View {
    @State var label:String
    @State var value:String?
    var body: some View {
        VStack(spacing:8){
            Image(systemName: label)
            Text(value ?? "0")
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(maxHeight: .infinity,alignment: .top)
    }
}

