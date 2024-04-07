//
//  SearchBarView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 23/03/24.
//

import SwiftUI
enum SearchDestination{
    case searchView
}

class DeviceInfo {
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

struct SearchBar: View {
    @Binding var searchText:String
    var body: some View {
        VStack{
            HStack{
                NavigationLink(value: SearchDestination.searchView) {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                        .frame(maxWidth: .infinity,alignment:.leading)
                }
                .foregroundStyle(.black)
              
                Spacer()
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
            }
            .padding(10)
            .background(.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
                
        }
        .navigationDestination(for: SearchDestination.self) { destination in
            switch destination{
            case .searchView:
                SearchView()
            }
        }
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}


// .padding(.leading,DeviceInfo.modelName == "iPhone8,4" ? 150 : 200)
