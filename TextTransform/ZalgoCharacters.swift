//
//  ZalgoCharacters.swift
//  TextTransform
//
//  Created by Rahul Aggarwal on 2021-06-05.
//

import Foundation

struct ZalgoCharacters: Codable {
    let above: [String]
    let inline: [String]
    let below: [String]
    
    init() {
        let url = Bundle.main.url(forResource: "zalgo", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        
        let decoder = JSONDecoder()
        self = try! decoder.decode(ZalgoCharacters.self, from: data)
    }
}
