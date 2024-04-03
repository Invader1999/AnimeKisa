//
//  SeasonAnimeView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import Kingfisher
import SwiftUI

enum SeasonAnimeDestination: Hashable {
    case seasonAnimeFullView
    case animeDetailsView(Node)
}

struct SeasonAnimeView: View {
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("This Season")
                        .font(.title2)
                        .bold()
                    Spacer()
                    NavigationLink(value: SeasonAnimeDestination.seasonAnimeFullView) {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                SeasonAnimeScrollView()
                    .environment(seasonAnimeViewModel)
            }
            .task {
                Task {
                    try await seasonAnimeViewModel.getSeasonalAnimeDetails(limit: "500")
                }
            }
        }
        .navigationDestination(for: SeasonAnimeDestination.self) { destination in
            switch destination {
            case .seasonAnimeFullView:
                SeasonAnimeFullView()
                    .environment(customTabBarHide)
                    .environment(seasonAnimeViewModel)

            case .animeDetailsView(let animeNode):
                AnimeDetailsView(getAnime: animeNode)
                    .environment(customTabBarHide)
                    .environment(animeDetailsViewModel)
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        SeasonAnimeView()
            .environment(CustomTabBarHide())
            .environment(SeasonAnimeViewModel())
            .environment(AnimeDetailsViewModel())
    }
}

struct SeasonAnimeTile: View {
    @State var imageURL: String
    @State var animeTitle: String
    @State var rating: String
    var body: some View {
        VStack {
            KFImage(URL(string: imageURL))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 120, height: 160)
                        .foregroundColor(.blue.opacity(0.1))
                }
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.leading)

            Text(animeTitle)
                .frame(width: 100, alignment: .leading)
                .padding(.leading)
                .lineLimit(2)

            Text(rating)
                .frame(width: 100, alignment: .leading)
                .padding(.leading)
                .lineLimit(2)
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }
}

struct SeasonAnimeScrollView: View {
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    var body: some View {
        
        ScrollView(.horizontal) {
            SeasonAnimeForLoop()
                .environment(seasonAnimeViewModel)
            // .frame(maxWidth: .infinity,alignment: )
        }
        .scrollIndicators(.hidden)
    }
}

// #Preview(body: {
//    SeasonAnimeScrollView()
//        .environment(CustomTabBarHide())
//        .environment(SeasonAnimeViewModel())
// })

struct SeasonAnimeForLoop: View {
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    var body: some View {
        HStack {
            ForEach(seasonAnimeViewModel.seasonAnimeDataArray) { datum in
                ForEach(datum.data!, id: \.self) { insideData in
                    NavigationLink(value: SeasonAnimeDestination.animeDetailsView(insideData.node ?? Node(id: 21, title: "", mainPicture: MainPicture(medium: "", large: "")))){
                        SeasonAnimeTile(imageURL: insideData.node?.mainPicture?.medium ?? "", animeTitle: insideData.node?.title ?? "", rating: "0.00")
                        }
                    }
            }
        }
    }
}
