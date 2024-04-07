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
    @Environment(\.dismiss) var dismiss
    var body: some View {
        LazyVStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(seasonAnimeViewModel.animeDetailsArray) { datum in
                        NavigationLink(value: SeasonAnimeDestination.animeDetailsView(datum)) {
                            SeasonAnimeTile(imageURL: datum.mainPicture?.large ?? "No Data", animeTitle: datum.title ?? "No Data", rating: "\(datum.mean ?? 0.00)")
                        }
                        .tint(.black)
                    }
                }
                
                //.padding(.leading, 100)
                .padding(.top)
                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .scrollIndicators(.hidden)
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            dismiss()
                        }
                    Text("\(seasonAnimeViewModel.year) \(seasonAnimeViewModel.season)" )
                        .bold()
                        .font(.title2)
                }
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
    SeasonAnimeFullView()
        .environment(CustomTabBarHide())
        .environment(SeasonAnimeViewModel())
}
