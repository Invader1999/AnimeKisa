//
//  AnimeDetailsView.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//

import Kingfisher
import SwiftUI

struct AnimeDetailsView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(\.dismiss) var dismiss
    @State var getAnime: AnimeDetailsModel
    var body: some View {
        ScrollView {
            LazyVStack {
                VStack {
                    HStack {
                        KFImage(URL(string: getAnime.mainPicture?.large
                                ?? ""))
                            .resizable()
                            .placeholder {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 120, height: 160)
                                    .foregroundColor(.blue.opacity(0.1))
                            }
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.leading)

                        VStack(spacing: 10) {
                            Text(getAnime.title ?? "")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TopLabel(icon: "movieclapper.fill", value: getAnime.source ?? "No Data")
                            TopLabel(icon: "stopwatch", value: "\(getAnime.numEpisodes ?? 0)")
                            TopLabel(icon: "dot.radiowaves.up.forward", value: getAnime.status ?? "No Data")
                            TopLabel(icon: "star.fill", value: "\(getAnime.mean ?? 0.00)")
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.trailing)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(getAnime.genres ?? [], id: \.id) { genre in
                            Text(genre.name ?? "No Data")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1)
                                }
                        }
                    }
                }
                .padding(.top)
                .scrollIndicators(.hidden)
                .scrollClipDisabled()

                SynopsisView(getAnime: getAnime)
                    .padding(.top)
                    .environment(animeDetailsViewModel)

                StatsView(getAnime: getAnime)
                    .padding(.top)
                    .environment(animeDetailsViewModel)

                MoreInfoView(getAnime: getAnime)
                    .padding(.top)
                    .environment(animeDetailsViewModel)

                CharcatersView()
                    .padding(.top)
                    .environment(animeDetailsViewModel)
                
                VoiceActorsView()
                    .padding(.top)
                    .environment(animeDetailsViewModel)
                
                ThemesView()
                    .padding(.top)
                    .environment(animeDetailsViewModel)
            }
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .onTapGesture {
                                dismiss()
                            }
                        Text("Details")
                            .font(.title2)
                    }
                }
            })
            .onAppear {
                customTabBarHide.show = false
            }
            .onDisappear {
                customTabBarHide.show = true
                // getAnime.id = nil
            }
            .task {
                Task {
                    // try await animeDetailsViewModel.getAnimeDetails(id: getAnime.id ?? 21)
                    try await animeDetailsViewModel.getAnimeThemesDetails(id: getAnime.id ?? 21)
                    try await animeDetailsViewModel.getAnimeCharacters(id: getAnime.id ?? 21)
                }
            }
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}

// #Preview {
//    AnimeDetailsView(title: "Tsuki ga Michubiku Isekai Douchuu 2nd Season", getAnime: Node(id: 21, title: "", mainPicture: MainPicture(medium: "", large: "")))
//        .environment(AnimeDetailsViewModel())
//        .environment(CustomTabBarHide())
// }

struct TopLabel: View {
    @State var icon: String
    @State var value: String
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(value)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct GenreTile: View {
    @State var genre: String
    var body: some View {
        Text(genre)
    }
}












