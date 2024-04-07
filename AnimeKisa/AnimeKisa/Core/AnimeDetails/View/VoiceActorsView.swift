//
//  VoiceActorsView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI

struct VoiceActorsView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel

    var body: some View {
        LazyVStack {
            Text("Voice Actors")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(animeDetailsViewModel.charactersArray.flatMap { $0.data ?? [] }, id: \.id) { innerData in
                        if let voiceActors = innerData.voiceActors {
                            ForEach(voiceActors, id: \.person?.id) { voiceActorData in
                                CharacterAndVoiceActorsTileView(
                                    imageURL: voiceActorData.person?.images?.jpg?.imageURL ?? "No URL",
                                    title: voiceActorData.person?.name ?? "Unknown"
                                )
                            }
                        }
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
    }
}

// #Preview {
//    VoiceActorsView()
//        .environment(AnimeDetailsViewModel())
// }
struct TodayAnimeVoiceActorsView: View {
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel

    var body: some View {
        LazyVStack {
            Text("Voice Actors")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(todayAnimeViewModel.charactersArray.flatMap { $0.data ?? [] }, id: \.id) { innerData in
                        if let voiceActors = innerData.voiceActors {
                            ForEach(voiceActors, id: \.person?.id) { voiceActorData in
                                CharacterAndVoiceActorsTileView(
                                    imageURL: voiceActorData.person?.images?.jpg?.imageURL ?? "No URL",
                                    title: voiceActorData.person?.name ?? "Unknown"
                                )
                            }
                        }
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
    }
}
