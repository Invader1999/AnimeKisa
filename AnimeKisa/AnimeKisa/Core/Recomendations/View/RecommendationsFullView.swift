//
//  RecommendationsDetailView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 29/03/24.
//

import SwiftUI

enum RecommmendedFullViewDestination:Hashable{
    case animeDetailsView(AnimeDetailsModel)
}

struct RecommendationsFullView: View {
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(RecommendationViewModel.self) var recommendationViewModel
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @Environment(LoginViewModel.self) var loginViewModel
    var body: some View {
        LazyVStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(recommendationViewModel.animeDetailsArray, id: \.id) { item in
                        NavigationLink(value: RecommmendedFullViewDestination.animeDetailsView(item)) {
                            RecommendationAnimeTile(imageURL: item.mainPicture?.large ?? "No Data", animeTitle: item.title ?? "No Data", rating: "\(item.mean ?? 0.00)")
                        }
                        .tint(.black)
                    }
                }
                //.padding(.leading, 100)
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .scrollIndicators(.hidden)
        }
        .navigationDestination(for: RecommmendedFullViewDestination.self, destination: { destinations in
            switch destinations{
            case .animeDetailsView(let animeDetails):
                AnimeDetailsView(getAnime: animeDetails)
                    .environment(customTabBarHide)
                    .environment(animeDetailsViewModel)
                    .navigationBarBackButtonHidden()
            }
        })
        .task {
            Task{
                    try await recommendationViewModel.getRecommendationAnimeDetails(limit: "100", accessToken: loginViewModel.token?.access_token ?? "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjAxYzVhY2VmN2NjNzdmMDBhMTFmZjc4YzgyMDY0OTEyNDkzNzc2NTk5ZDJlNDE5ZjEwNmQ4NzZmYzIzMTc1NzE4MWFjNDI1OWQzYzJhOGI4In0.eyJhdWQiOiJlNjZkZmMzNzZjNDNiYWVmMWEzM2FmZDA1YjVjY2NlOSIsImp0aSI6IjAxYzVhY2VmN2NjNzdmMDBhMTFmZjc4YzgyMDY0OTEyNDkzNzc2NTk5ZDJlNDE5ZjEwNmQ4NzZmYzIzMTc1NzE4MWFjNDI1OWQzYzJhOGI4IiwiaWF0IjoxNzExNjg3NzY0LCJuYmYiOjE3MTE2ODc3NjQsImV4cCI6MTcxNDM2NjE2NCwic3ViIjoiMTU2MjA1NzciLCJzY29wZXMiOltdfQ.Mqb2jDFHxhNSlnNgJUZl3TVujN-Sd4MX_DnD5Hrw_d0hAVZPAJX7VZr_15Z9hldMoflbRZgri6og1fz9q4CkPovqlpfctU46QvRrGm3TkGwXzSNa2tcuDadNLmRi4qXDdlTsWw9U3FGfgG3uAa_-fmIktcTLcU1ynXc63XD9Z1a3DceY9-691Zd1HKDdH7Wxi1Q8o_Wx58r_Z_k8eeVEKEk627OQau_eqqLsChhFAW4blmUQ8CuMjLbXi9JDV_o3ALUptHkJ3cWIroS_djdiy8FBt7CdPhhiv61XJwqsNMMK2-j3kNAkgMVE7aMcHzlUvP_cS7EbeJbhkle11s3HjA")
                
            }
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
    
    NavigationStack{
        RecommendationsFullView()
            .environment(RecommendationViewModel())
            .environment(CustomTabBarHide())
            .environment(LoginViewModel())
        .environment(AnimeDetailsViewModel())
    }
}
