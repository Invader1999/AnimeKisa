//
//  TodayAnimeDetailsView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 07/04/24.
//

import Kingfisher
import SwiftUI

struct TodayAnimeDetailsView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    @Environment(\.dismiss) var dismiss
    @State var getAnime: TodayAnimeDatum

    var body: some View {
        ScrollView {
            LazyVStack {
                VStack {
                    HStack {
                        if let webpImage = getAnime.images?["jpg"], let largeImageURL = webpImage.largeImageURL {
                            KFImage(URL(string: largeImageURL))
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
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 120, height: 160)
                                .foregroundColor(.blue.opacity(0.1))
                        }

                        VStack(spacing: 10) {
                            Text(getAnime.title ?? "")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            TopLabel(icon: "movieclapper.fill", value: getAnime.source ?? "No Data")
                            TopLabel(icon: "stopwatch", value: "\(getAnime.episodes ?? 0)")
                            TopLabel(icon: "dot.radiowaves.up.forward", value: getAnime.status?.rawValue ?? "No Data")
                            TopLabel(icon: "star.fill", value: "\(getAnime.score ?? 0.00)")
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.trailing)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(getAnime.genres ?? [],id:\.malID) { genre in
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

                    TodaySynopsisView(getAnime: getAnime)
                        .padding(.top)
                        .environment(todayAnimeViewModel)
                    
                    TodayAnimeStatsView(getAnime: getAnime)
                        .padding(.top)
                        .environment(todayAnimeViewModel)
                    
                    TodayAnimeMoreInfoView(getAnime: getAnime)
                        .padding(.top)
                        .environment(todayAnimeViewModel)
                    
                    TodayAnimeCharcatersView()
                        .padding(.top)
                        .environment(todayAnimeViewModel)

                    TodayAnimeVoiceActorsView()
                        .padding(.top)
                        .environment(todayAnimeViewModel)
                    
                    TodayAnimeThemesView()
                        .padding(.top)
                        .environment(todayAnimeViewModel)
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
                        try await todayAnimeViewModel.getAnimeThemesDetails(id: getAnime.malID ?? 21)
                        try await todayAnimeViewModel.getAnimeCharacters(id: getAnime.malID ?? 21)
                    }
                }
                .padding(.leading)
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
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}
