//
//  TabPosition.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 23/03/24.
//

import SwiftUI

struct PositionKey:PreferenceKey{
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
extension View{
    @ViewBuilder
    func viewPosition(completion:@escaping (CGRect)->()) -> some View{
        self
            .overlay {
                GeometryReader{
                    let rect = $0.frame(in:.global)
                    
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self,perform:completion)
                }
            }
    }
}
