//
//  SynopsisView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI

struct SynopsisView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @State var showFullText: Bool = false
    @State var getAnime: AnimeDetailsModel
    var body: some View {
        VStack {
            Text(getAnime.synopsis ?? "No Data")
                .lineLimit(showFullText ? 20 : 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Image(systemName: showFullText ? "chevron.up" : "chevron.down")
                .onTapGesture {
                    withAnimation(.spring) {
                        showFullText.toggle()
                    }
                }
                .padding(.top)
        }
        .padding(.trailing, 5)
    }
}


struct TodaySynopsisView: View {
    @Environment(TodayAnimeViewModel.self) var todayanimeDetailsViewModel
    @State var showFullText: Bool = false
    @State var getAnime: TodayAnimeDatum
    var body: some View {
        VStack {
            Text(getAnime.synopsis ?? "No Data")
                .lineLimit(showFullText ? 20 : 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Image(systemName: showFullText ? "chevron.up" : "chevron.down")
                .onTapGesture {
                    withAnimation(.spring) {
                        showFullText.toggle()
                    }
                }
                .padding(.top)
        }
        .padding(.trailing, 5)
    }
}
