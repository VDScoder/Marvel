//
//  Character.swift
//  Marvel
//
//  Created by Дмитрий Волынкин on 18.04.2021.
//

import SwiftUI


struct APIresult: Codable {
    var data: APIcharacterData
}

struct APIcharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description:String
    var thumbnail: [String:String]
    var urls: [[String:String]]
    
}


    
