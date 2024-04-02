//
//  HomeView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 23/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText: String = ""
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    @Environment(CalenderViewModel.self) var calenderViewModel
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    @Environment(LoginViewModel.self) var loginViewModel
    @Environment(RecommendationViewModel.self) var recommendationViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView {
                //MARK: - Top Search Bar
                SearchBar(searchText: $searchText)
                
                //MARK: - Category Tile View
                CategoryTileView()
                    .environment(todayAnimeViewModel)
                    .environment(customTabBarHide)
                    .environment(calenderViewModel)
                    .padding(.top,6)
                
                //MARK: - Today Airing Anime
                TodayAnimeView()
                    .environment(customTabBarHide)
                    .environment(todayAnimeViewModel)
                    .padding(.top)
                
                SeasonAnimeView()
                    .environment(customTabBarHide)
                    .environment(seasonAnimeViewModel)
                    .padding(.top)
                
                RecommendationsView()
                    .environment(customTabBarHide)
                    .environment(loginViewModel)
                    .environment(recommendationViewModel)
            }
            .scrollClipDisabled()
           // .scrollContentBackground(.visible)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HomeView()
        .environment(CustomTabBarHide())
        .environment(TodayAnimeViewModel())
        .environment(CalenderViewModel())
        .environment(SeasonAnimeViewModel())
        .environment(LoginViewModel())
        .environment(RecommendationViewModel())
}
