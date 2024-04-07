//
//  StatsView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI

struct StatsView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @State var getAnime: AnimeDetailsModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Stats")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            HStack(spacing: 15) {
                StatsIcons(label: "chart.bar.fill", value: "#\(getAnime.rank ?? 0)", secondaryLable: "")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "hand.thumbsup.fill", value: "\(getAnime.numScoringUsers ?? 0)", secondaryLable: "hand.thumbsdown.fill")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "person.2.fill", value: "\(getAnime.numListUsers ?? 0)", secondaryLable: "")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "bolt.horizontal.fill", value: "\(getAnime.popularity ?? 0)", secondaryLable: "")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StatsIcons: View {
    @State var label: String
    @State var value: String?
    @State var secondaryLable: String?
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Image(systemName: label)
                Image(systemName: secondaryLable!)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            Text(value ?? "0")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


struct TodayAnimeStatsView: View {
    @Environment(TodayAnimeViewModel.self) var todayanimeViewModel
    @State var getAnime: TodayAnimeDatum
    var body: some View {
        VStack(spacing: 20) {
            Text("Stats")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            HStack(spacing: 15) {
                StatsIcons(label: "chart.bar.fill", value: "#\(getAnime.rank ?? 0)", secondaryLable: "")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "hand.thumbsup.fill", value: "\(getAnime.scoredBy ?? 0)", secondaryLable: "hand.thumbsdown.fill")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "person.2.fill", value: "\(getAnime.members ?? 0)", secondaryLable: "")

                Divider()
                    .foregroundStyle(.black)

                StatsIcons(label: "bolt.horizontal.fill", value: "\(getAnime.popularity ?? 0)", secondaryLable: "")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

