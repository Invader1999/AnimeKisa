//
//  Tab.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 23/03/24.
//

import SwiftUI

enum Tab:String,CaseIterable{
    case home = "Home"
    case anime = "Anime"
    case manga = "Manga"
    case forum = "Forum"
    
    var systemImage:String{
        switch self{
        case .home:
            return "house"
        case .anime:
            return "tropicalstorm.circle"
        case .manga:
            return "book.pages"
        case .forum:
            return "message.badge"
        }
    }
    
    var index:Int{
        return Tab.allCases.firstIndex(of: self) ?? 0 
    }
}
