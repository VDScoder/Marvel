//
//  CharactersView.swift
//  Marvel
//
//  Created by Дмитрий Волынкин on 18.04.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search caracter", text: $homeData.searchQuery)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }.padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    if let characters = homeData.fetchCharacters {
                        if characters.isEmpty {
                            Text("No Result found")
                                .padding(.top,20)
                        }else {
                            ForEach(characters) {data in
                                CharacterRowView(character: data)
                            }
                        }
                    }else {
                        if homeData.searchQuery != "" {
                        ProgressView()
                            .padding(.top, 20)
                        }
                    }
                    
                }
            }).navigationBarTitle("Marvel")
        }
        
        
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CharacterRowView: View {
    var character: Character
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: extractImage(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(character.name)
                    .font(.title3)
                    .bold()
                
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 10) {
                    ForEach(character.urls, id:\.self) {data in
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extracrURKType(data: data)),
                            label: {
                                Text(extracrURKType(data: data))
                            })
                    }
                    
                }.padding()
            })
            
            Spacer(minLength: 0)
        }.padding(.horizontal)
    }
    
    func extractImage(data: [String: String]) -> URL {
        let path = data["data"] ?? ""
        let ext = data["extension"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String:String]) -> URL{
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    func extracrURKType(data: [String:String]) -> String {
        let type = data["type"] ?? ""
        return type.capitalized
    }
}
