//
//  CalenderView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 25/03/24.
//

import Foundation
import Kingfisher
import SwiftUI

struct CalenderView: View {
    @Environment(CustomTabBarHide.self) var customTabBarHide
    @Environment(CalenderViewModel.self) var calenderViewModel
    @State var isLoading = true
    var body: some View {
        HStack {
                CalenderScrollView()
                    .environment(calenderViewModel)
        }
        .navigationTitle("Calender")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: calenderViewModel.selectedDay) { _, newValue in
            Task {
                try await calenderViewModel.getAiringAnimeData(day: newValue)
            }
        }
        .onChange(of: calenderViewModel.isLoading) { _, newValue in
            isLoading = newValue
        }
        .task {
            Task {
                try await calenderViewModel.getAiringAnimeData(day: calenderViewModel.selectedDay)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                customTabBarHide.show = false
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                customTabBarHide.show = true
                calenderViewModel.selectedDay = calenderViewModel.getCurrentDayString()
            }
        }
    }
}

#Preview {
    CalenderView()
        .environment(CustomTabBarHide())
        .environment(CalenderViewModel())
}

struct CalenderAnimeTile: View {
    @State var imageURL: String
    @State var animeTitle: String
    @State var airingTime: String
    var calenderViewModel: CalenderViewModel
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

            Text(airingTime)
                .frame(width: 100, alignment: .leading)
                .padding(.leading)
                .lineLimit(2)
                .font(.callout)
                .foregroundStyle(.black.opacity(0.7))
        }
    }
}

//#Preview {
//    CalenderAnimeTile(imageURL: "https://cdn.myanimelist.net/images/anime/1618/134534.jpg", animeTitle: "Lv2 kara Cheat datta", airingTime: "23:00", calenderViewModel: CalenderViewModel())
//}

struct CalenderScrollView: View {
    
    @Environment(CalenderViewModel.self) var calenderViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(calenderViewModel.animeAiringDataArray, id: \.id) { innerData in
                    ForEach(innerData.data ?? [], id: \.id) { finalData in
                        if let imageUrl = finalData.images?.values.first?.imageURL {
                            CalenderAnimeTile(imageURL: imageUrl, animeTitle: finalData.title ?? "", airingTime: finalData.BrodcastTime ?? "00:00", calenderViewModel: calenderViewModel)
                        }
                    }
                }
            }
            .padding(.leading, 100)
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
        .scrollIndicators(.hidden)
        .overlay {
            CalenderMenuView(calenderViewModel: calenderViewModel)
        }
    }
}
