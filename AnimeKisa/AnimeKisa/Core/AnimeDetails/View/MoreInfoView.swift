//
//  MoreInfoView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI


struct MoreInfoView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    @State var getAnime: AnimeDetailsModel
    var body: some View {
        VStack(spacing: 10) {
            Text("More Info")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            // Text(animeDetailsViewModel.animeDetails?.alternativeTitles?.ja ?? "No Data")
            MoreInfoRow(label: "Synonyms", value: getAnime.alternativeTitles?.synonyms?.first)
            MoreInfoRow(label: "Japanese", value: getAnime.alternativeTitles?.ja)
            MoreInfoRow(label: "English", value: getAnime.alternativeTitles?.en)

            Divider()
                .background(.black)
                .padding(.leading, -20)

            MoreInfoRow(label: "Start Date", value: getAnime.startDate)
            MoreInfoRow(label: "End Date", value: getAnime.endDate)
            MoreInfoRow(label: "Broadcast", value: "\(getAnime.broadcast?.dayOfTheWeek ?? "No Data") \(getAnime.broadcast?.startTime ?? "No Data")(JST)")
            MoreInfoRow(label: "Duration", value: "\(getAnime.averageEpisodeDurationInMinutes)")

            Divider()
                .background(.black)
                .padding(.leading, -20)
            MoreInfoRow(label: "Studios", value: getAnime.studios?.first?.name)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct MoreInfoRow: View {
    @State var label: String
    @State var value: String?
    var body: some View {
        HStack {
            Text(label)
                // .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .top)
            Spacer()

            Text(value ?? "No Data")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .frame(width: 200)
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
