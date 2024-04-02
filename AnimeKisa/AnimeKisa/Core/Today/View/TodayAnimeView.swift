//
//  TodayAnimeView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 24/03/24.
//
import Kingfisher
import SwiftUI

struct TodayAnimeView: View {
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    @Environment(CustomTabBarHide.self) var customTabBar

    var body: some View {
        VStack {
            HStack {
                Text("Today")
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink(value: CategoryDestination.calenderView) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                        .bold()
                }
            }
            .padding(.horizontal)

            TodayAnimeScrollView(todayAnimeiViewModel: todayAnimeViewModel)
                .padding(.leading)
                .frame(height: 150)
        }
        .task {
            Task {
                try await todayAnimeViewModel.getTodayAiringAnimeData()
            }
        }
    }
}

struct TodayAnimeScrollView: View {
    
    var todayAnimeiViewModel: TodayAnimeViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(todayAnimeiViewModel.todayAnimeDataArray, id: \.id) { innerData in
                    ForEach(innerData.data ?? [], id: \.id) { finalData in
                        if let imageUrl = finalData.images?.values.first?.imageURL{
                            TodayAnimeTileView(imageURL: imageUrl, animeTitle: finalData.title ?? "", airingTime:finalData.convertedBroadcastTime ?? "", rating: finalData.score ?? 0.0)
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
       
        
        
    }
}

//#Preview {
//    TodayAnimeView()
//        .environment(TodayAnimeViewModel())
//        .environment(CustomTabBarHide())
//}

struct TodayAnimeTileView: View {
    @State var imageURL: String
    @State var animeTitle: String
    @State var airingTime: String
    @State var rating: Double

    var body: some View {
        HStack(spacing:0) {
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
               

            VStack {
                Text(animeTitle)
                    .frame(width: 200,alignment: .leading)
                    .padding(.leading)
                    .lineLimit(2)
                
                Text(airingTime)
                    .frame(width: 200,alignment: .leading)
                    .padding(.leading)
                    .lineLimit(2)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.7))
                
                HStack{
                    Image(systemName: "star.fill")
                    Text(String(format: "%.2f", rating))
                }
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity,alignment:.leading)
                .padding(.leading)
            }
            //.frame(maxHeight: .infinity,alignment: .topLeading)
            
        }
        .scrollTargetLayout()
        .frame(maxHeight: .infinity,alignment: .top)
        .frame(width: 330)
    }
}
#Preview(body: {
    TodayAnimeTileView(imageURL: "https://cdn.myanimelist.net/images/anime/1789/139296.jpg", animeTitle: "Maougun Saikyou no Majutsushi wa Ningen datta", airingTime: "Airing in 11 hr 11 min", rating: 0.00)
})
