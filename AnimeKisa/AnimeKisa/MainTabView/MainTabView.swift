//
//  ContentView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 22/03/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var activeTab:Tab = .home
    @Namespace private var animation
    @State private var tabShapePosition:CGPoint = .zero
    @State var customTabBarShow = CustomTabBarHide()
    @State var todayAnimeViewModel = TodayAnimeViewModel()
    @State var calenderViewModel = CalenderViewModel()
    @State var seasonAnimeViewModel = SeasonAnimeViewModel()
    @State var loginViewModel = LoginViewModel()
    @State var recommendationViewModel = RecommendationViewModel()
    @State var animeDetailsViewModel = AnimeDetailsViewModel()
    @State var showTabBar:Bool = true

    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack{
            TabView(selection: $activeTab) {
                HomeView()
                    .tag(Tab.home)
                    .environment(customTabBarShow)
                    .environment(todayAnimeViewModel)
                    .environment(calenderViewModel)
                    .environment(seasonAnimeViewModel)
                    .environment(loginViewModel)
                    .environment(recommendationViewModel)
                    .environment(animeDetailsViewModel)
                    
                
               AnimeView()
                    .tag(Tab.anime)
                   
                
                MangaView()
                    .tag(Tab.manga)
                  
                
                ForumView()
                    .tag(Tab.forum)
        
            }
            if showTabBar == true{
                CustomTabbar()
                    
            }
//                    .opacity(Double(showTabBar))
//                    .disabled(showTabBar == 1 ? false : true)
            
        }
        .onOpenURL(perform: { url in
            loginViewModel.handleRedirectURL(url: url)
        })
        .onChange(of: customTabBarShow.show, { oldValue, newValue in
            withAnimation(.smooth) {
                showTabBar = newValue
            }
        })
    }
    
    @ViewBuilder
    func CustomTabbar(_ tint:Color = .blue, _ inactiveTint:Color = .blue) -> some View{
        HStack(spacing:0){
            ForEach(Tab.allCases,id: \.rawValue){
               TabItem(
                tint: tint,
                inactiveTint: inactiveTint,
                tab: $0,
                animation: animation,
                activeTab: $activeTab,
                position: $tabShapePosition
               )    
            }
        }
        .padding(.horizontal,15)
        .padding(.vertical,10)
        .background{
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top,25)
                
               
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7),value: activeTab)
    }
}

struct TabItem:View {
    var tint:Color
    var inactiveTint:Color
    var tab:Tab
    var animation:Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position:CGPoint
    @State private var tabPosition:CGPoint = .zero
    var body: some View {
        VStack(spacing:0){
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundStyle(activeTab == tab ? .white : tint)
                .frame(width: activeTab == tab ? 58 : 35,height: activeTab == tab ? 58 : 35)
                .background{
                    if activeTab == tab{
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundStyle(activeTab == tab ? tint : .black)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            if activeTab == tab{
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                position.x = tabPosition.x
            }
        }
    }
}

#Preview {
    MainTabView()
}

@Observable
class CustomTabBarHide{
    var show:Bool = true
    
    
}
