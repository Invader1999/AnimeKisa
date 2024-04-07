//
//  Anime Raking View.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 24/03/24.
//

import SwiftUI

struct AnimeRankingView: View {
    @Environment(CustomTabBarHide.self) var customTabBarHide
   
    var body: some View {
        VStack {
            Text("Anime Ranking View")
        }
        .onAppear {
            DispatchQueue.main.async {
                customTabBarHide.show = false
            }
        }
//        .onDisappear {
//            DispatchQueue.main.async {
//                customTabBarHide.show = true
//            }
//        }
    }
}

#Preview {
    AnimeRankingView()
        .environment(CustomTabBarHide())
}
