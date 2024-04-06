//
//  CharactersAndVoiceActorsTileView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 06/04/24.
//

import SwiftUI
import Kingfisher

struct CharacterAndVoiceActorsTileView: View {
    @State var imageURL: String?
    @State var title: String?

    var body: some View {
        VStack {
            KFImage(URL(string: imageURL
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
                .frame(width: 80, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(title ?? "No Data")
                .frame(width: 80, height: 60)
                .frame(maxWidth: .infinity, alignment: .top)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
