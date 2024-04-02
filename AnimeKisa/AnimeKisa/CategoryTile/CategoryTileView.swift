//
//  CategoryTileView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 24/03/24.
//

import SwiftUI

enum CategoryDestination {
    case animeRankingView
    case calenderView
}

struct CategoryTileView: View {
    @State var tabSelection = 0
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    @Environment(CalenderViewModel.self) var calenderViewModel
    
    var body: some View {
        Grid {
            GridRow {
                NavigationLink(value: CategoryDestination.animeRankingView) {
                    CategoryTileDetails(imageName: "movieclapper.fill", title:
                        "Anime Ranking")
                }

                CategoryTileDetails(imageName: "books.vertical.fill", title: "Manga Ranking")
            }

            GridRow {
                NavigationLink(value: SeasonAnimeDestination.seasonAnimeFullView) {
                    CategoryTileDetails(imageName: "camera.macro", title: "Seasonal Chart")
                }

                NavigationLink(value: CategoryDestination.calenderView) {
                    CategoryTileDetails(imageName: "calendar", title: "Calender            ")
                }
            }
        }
        .navigationDestination(for: CategoryDestination.self) { destionation in
            switch destionation {
            case .animeRankingView:
                AnimeRankingView()
                    .environment(customTabBarHide)
            case .calenderView: 
                CalenderView()
                    .environment(calenderViewModel)
                    .environment(customTabBarHide)
            }
        }
    }
}

#Preview {
    CategoryTileView()
        .environment(CustomTabBarHide())
        .environment(TodayAnimeViewModel())
        .environment(CalenderViewModel())
        
}

struct CategoryTileDetails: View {
    @State var imageName: String
    @State var title: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundStyle(.blue)
            Text(title)
                .foregroundStyle(.black)
        }
        .padding()
        .background(.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
