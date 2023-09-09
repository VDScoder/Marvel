//
//  Home.swift
//  Marvel
//
//  Created by Дмитрий Волынкин on 18.04.2021.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
        TabView {
            
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Caracters")
                
                }.environmentObject(homeData)
            
            Text("Comics")
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                        Text("Comix")
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
