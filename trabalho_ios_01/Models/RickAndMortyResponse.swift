//
//  RickAndMortyResponse.swift
//  trabalho_ios_01
//
//  Created by BRUNO MOREIRA BATISTA on 06/09/23.
//

import Foundation

struct RickAndMortyResponse: Decodable {
    let results: [RickAndMortyCharacter]
    
    enum CodingKeys: CodingKey{
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([RickAndMortyCharacter].self, forKey: .results)
    }
}
