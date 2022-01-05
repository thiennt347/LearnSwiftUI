//
//  Home.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/4/22.
//

import SwiftUI

struct Home: View {
    @Binding var selectedTab: String
    @Binding var menuClick: Bool
    
    init(selectedTab: Binding<String>,
         menuClick: Binding<Bool>) {
        self._menuClick = menuClick
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    //All tab in side menu
    var body: some View {
        TabView(selection: $selectedTab) {
            //Views
            HomePageView(menuClick: $menuClick).tag("Home")
            
            TemplatesPageView(menuClick: $menuClick).tag("Templates")
            
            CategoriesPageView(menuClick: $menuClick).tag("Categories")
            
            AnalyticsPageView(menuClick: $menuClick).tag("Analytics")
            
            SettingsPageView(menuClick: $menuClick).tag("Settings")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
