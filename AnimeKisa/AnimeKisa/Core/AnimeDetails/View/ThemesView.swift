//
//  ThemesView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI

struct ThemesView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Opening Themes")
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(animeDetailsViewModel.animeThemes) { animeTheme in
                if let openings = animeTheme.data?.openings {
                    ForEach(openings, id: \.self) { theme in
                        Text(theme)
                            .onTapGesture {
                                openYouTubeSearch(query: theme)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blue)
                    }
                } else {
                    Text("No opening themes available")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Text("Ending Themes")
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(animeDetailsViewModel.animeThemes) { animeTheme in
                if let openings = animeTheme.data?.endings {
                    ForEach(openings, id: \.self) { theme in
                        Text(theme)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blue)
                    }
                } else {
                    Text("No ending themes available")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func openYouTubeSearch(query: String) {
        if let url = URL(string: "https://www.youtube.com/results?search_query=\(query.replacingOccurrences(of: " ", with: "+"))") {
            UIApplication.shared.open(url)
        }
    }
}


struct TodayAnimeThemesView: View {
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Opening Themes")
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(todayAnimeViewModel.animeThemes) { animeTheme in
                if let openings = animeTheme.data?.openings {
                    ForEach(openings, id: \.self) { theme in
                        Text(theme)
                            .onTapGesture {
                                openYouTubeSearch(query: theme)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blue)
                    }
                } else {
                    Text("No opening themes available")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Text("Ending Themes")
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(todayAnimeViewModel.animeThemes) { animeTheme in
                if let openings = animeTheme.data?.endings {
                    ForEach(openings, id: \.self) { theme in
                        Text(theme)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blue)
                    }
                } else {
                    Text("No ending themes available")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func openYouTubeSearch(query: String) {
        if let url = URL(string: "https://www.youtube.com/results?search_query=\(query.replacingOccurrences(of: " ", with: "+"))") {
            UIApplication.shared.open(url)
        }
    }
}
