//
//  SeasonAnimeFullView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 27/03/24.
//

import SwiftUI

struct SeasonAnimeFullView: View {
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(SeasonAnimeViewModel.self) var seasonAnimeViewModel
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(seasonAnimeViewModel.seasonAnimeDataArray, id: \.id) { item in
                        ForEach(item.data ?? [],id:\.node?.id){details in
                            SeasonAnimeTile(imageURL: details.node?.mainPicture?.medium ?? "", animeTitle: details.node?.title ?? "", rating: "0.00")
                        }
                    }
                }
                //.padding(.leading, 100)
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            DispatchQueue.main.async {
                customTabBarHide.show = false
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                customTabBarHide.show = true
            }
        }
    }
    
}

#Preview {
    SeasonAnimeFullView()
        .environment(CustomTabBarHide())
}
