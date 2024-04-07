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


struct TodayAnimeMoreInfoView: View {
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    @State var getAnime: TodayAnimeDatum
    
    var body: some View {
        VStack(spacing: 10) {
            Text("More Info")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            MoreInfoRow(label: "Synonyms", value: getAnime.titleSynonyms?.first)
            MoreInfoRow(label: "Japanese", value: getAnime.titleJapanese)
            MoreInfoRow(label: "English", value: getAnime.titleEnglish)

            Divider()
                .background(.black)
                .padding(.leading, -20)

            MoreInfoRow(label: "Start Date", value: formattedDate(getAnime.aired?.from))
            MoreInfoRow(label: "End Date", value: formattedDate(getAnime.aired?.to))
            MoreInfoRow(label: "Broadcast", value: "\(getAnime.broadcast?.string ?? "No Data")")
            MoreInfoRow(label: "Duration", value: "\(getAnime.duration ?? "24")")

            Divider()
                .background(.black)
                .padding(.leading, -20)
            MoreInfoRow(label: "Studios", value: getAnime.studios?.first?.name)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private func formattedDate(_ dateString: String?) -> String {
           guard let dateString = dateString else { return "No Data" }
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
           if let date = dateFormatter.date(from: dateString) {
               dateFormatter.dateFormat = "yyyy-MM-dd"
               return dateFormatter.string(from: date)
           } else {
               return "Invalid Date"
           }
       }
    
}

