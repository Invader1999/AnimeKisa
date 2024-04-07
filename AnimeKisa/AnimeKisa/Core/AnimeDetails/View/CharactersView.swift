//
//  CharactersView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI

struct CharcatersView: View {
    @Environment(AnimeDetailsViewModel.self) var animeDetailsViewModel
    var body: some View {
        LazyVStack(){
            Text("Charcaters")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(animeDetailsViewModel.charactersArray, id: \.id) { characterData in
                        ForEach(characterData.data ?? [], id: \.id) { character in
                            CharacterAndVoiceActorsTileView(imageURL: character.character?.images?.jpg?.imageURL, title: character.character?.name)
                        }
                    }
                }
            }
            .frame(height:190)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
    }
}

struct TodayAnimeCharcatersView: View {
    @Environment(TodayAnimeViewModel.self) var todayAnimeViewModel
    var body: some View {
        LazyVStack(){
            Text("Charcaters")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(todayAnimeViewModel.charactersArray, id: \.id) { characterData in
                        ForEach(characterData.data ?? [], id: \.id) { character in
                            CharacterAndVoiceActorsTileView(imageURL: character.character?.images?.jpg?.imageURL, title: character.character?.name)
                        }
                    }
                }
            }
            .frame(height:190)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
    }
}

