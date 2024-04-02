//
//  CalendeModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import SwiftUI

struct Tool:Identifiable{
    var id:String = UUID().uuidString
    var icon:String
    var name:String
    var color:Color
    var toolPostion:CGRect = .zero
    var showText:Bool
}
