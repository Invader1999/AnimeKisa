//
//  RecommendationsView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 28/03/24.
//

import SwiftUI
import Kingfisher

enum RecommmendedDestination{
    case recommendedDetailView
}


struct RecommendationsView: View {
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(LoginViewModel.self) var loginViewModel
    @Environment(RecommendationViewModel.self) var recommendationViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("Recommendations")
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink(value: RecommmendedDestination.recommendedDetailView) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                    .bold()
                }
                
            }
            .padding(.horizontal)
            
            if(loginViewModel.token != nil){
                Button{
                    loginViewModel.AuthenticationServicesLogin()
                }label:{
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.vertical,8)
                        .background{
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundStyle(.blue)
                                .frame(width: 150)
                        }
                    
                }
                .padding(.top,50)
            }
            else{
                RecommendationAnimeScrollView()
                    .environment(recommendationViewModel)
            }
        }
        .navigationDestination(for: RecommmendedDestination.self) { destination in
            switch destination{
            case .recommendedDetailView:
                RecommendationsFullView()
                    .environment(customTabBarHide)
                    .environment(recommendationViewModel)
                    .environment(loginViewModel)
            }
        }
//        .onChange(of: loginViewModel.token?.access_token, { oldValue, newValue in
//            Task{
//                    try await recommendationViewModel.getRecommendationAnimeDetails(limit: "20", accessToken:loginViewModel.token?.access_token ?? "")
//                
//            }
//        })
        .task {
            Task{
                    try await recommendationViewModel.getRecommendationAnimeDetails(limit: "20", accessToken: loginViewModel.token?.access_token ?? "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjAxYzVhY2VmN2NjNzdmMDBhMTFmZjc4YzgyMDY0OTEyNDkzNzc2NTk5ZDJlNDE5ZjEwNmQ4NzZmYzIzMTc1NzE4MWFjNDI1OWQzYzJhOGI4In0.eyJhdWQiOiJlNjZkZmMzNzZjNDNiYWVmMWEzM2FmZDA1YjVjY2NlOSIsImp0aSI6IjAxYzVhY2VmN2NjNzdmMDBhMTFmZjc4YzgyMDY0OTEyNDkzNzc2NTk5ZDJlNDE5ZjEwNmQ4NzZmYzIzMTc1NzE4MWFjNDI1OWQzYzJhOGI4IiwiaWF0IjoxNzExNjg3NzY0LCJuYmYiOjE3MTE2ODc3NjQsImV4cCI6MTcxNDM2NjE2NCwic3ViIjoiMTU2MjA1NzciLCJzY29wZXMiOltdfQ.Mqb2jDFHxhNSlnNgJUZl3TVujN-Sd4MX_DnD5Hrw_d0hAVZPAJX7VZr_15Z9hldMoflbRZgri6og1fz9q4CkPovqlpfctU46QvRrGm3TkGwXzSNa2tcuDadNLmRi4qXDdlTsWw9U3FGfgG3uAa_-fmIktcTLcU1ynXc63XD9Z1a3DceY9-691Zd1HKDdH7Wxi1Q8o_Wx58r_Z_k8eeVEKEk627OQau_eqqLsChhFAW4blmUQ8CuMjLbXi9JDV_o3ALUptHkJ3cWIroS_djdiy8FBt7CdPhhiv61XJwqsNMMK2-j3kNAkgMVE7aMcHzlUvP_cS7EbeJbhkle11s3HjA")
                
            }
        }
    }
}

#Preview {
    RecommendationsView()
        .environment(CustomTabBarHide())
        .environment(LoginViewModel())
        .environment(RecommendationViewModel())
}

struct RecommendationAnimeScrollView: View {
    @Environment(RecommendationViewModel.self) var recommendationAnimeViewModel
    var body: some View {
        ScrollView(.horizontal){
            HStack(){
                ForEach(recommendationAnimeViewModel.recommendationDataArray, id: \.id) { item in
                    ForEach(item.data ?? [],id:\.node?.id){details in
                        RecommendationAnimeTile(imageURL: details.node?.mainPicture?.medium ?? "", animeTitle: details.node?.title ?? "", rating: "0.00")
                    }
                }
            }
            //.frame(maxWidth: .infinity,alignment: )
        }
        .scrollIndicators(.hidden)
    }
}

struct RecommendationAnimeTile: View {
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
        .frame(maxHeight: .infinity,alignment: .top)
    }
}
