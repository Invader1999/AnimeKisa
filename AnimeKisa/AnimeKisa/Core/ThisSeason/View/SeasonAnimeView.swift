//
//  SeasonAnimeView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import SwiftUI
import Kingfisher

enum SeasonAnimeDestination{
    case seasonAnimeFullView
}

struct SeasonAnimeView: View {
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    @Environment(CustomTabBarHide.self) var customTabBarHide
    var body: some View {
        VStack{
            HStack{
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
            .frame(maxWidth: .infinity,alignment:.leading)
            .padding(.horizontal)
            .task {
                Task{
                    try await seasonAnimeViewModel.getSeasonalAnimeDetails(limit: "500")
                }
            }
            
            SeasonAnimeScrollView()
                .environment(seasonAnimeViewModel)
        }
        .navigationDestination(for: SeasonAnimeDestination.self) { destination in
            switch destination{
            case .seasonAnimeFullView:
                SeasonAnimeFullView()
                    .environment(customTabBarHide)
                    .environment(seasonAnimeViewModel)
            }
        }
        
    }
}

#Preview {
    SeasonAnimeView()
        .environment(CustomTabBarHide())
        .environment(SeasonAnimeViewModel())
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
        ScrollView(.horizontal){
            HStack(){
                ForEach(seasonAnimeViewModel.seasonAnimeDataArray, id: \.id) { item in
                    ForEach(item.data ?? [],id:\.node?.id){details in
                        SeasonAnimeTile(imageURL: details.node?.mainPicture?.medium ?? "", animeTitle: details.node?.title ?? "", rating: "0.00")
                    }
                }
            }
            //.frame(maxWidth: .infinity,alignment: )
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview(body: {
//    SeasonAnimeScrollView()
//        .environment(CustomTabBarHide())
//        .environment(SeasonAnimeViewModel())
//})
