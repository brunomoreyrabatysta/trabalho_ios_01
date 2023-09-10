//
//  RickAndMartyCharacter.swift
//  trabalho_ios_01
//
//  Created by BRUNO MOREIRA BATISTA on 06/09/23.
//

import Foundation

struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case imageURL = "image"
    }
    
    init(id: Int, name: String, status: String, imageURL: URL?) {
        self.id = id
        self.name = name
        self.status = status
        self.imageURL = imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        
        let imageString = try container.decode(String.self, forKey: .imageURL)
        
        self.imageURL = URL(string: imageString)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.imageURL?.absoluteString, forKey: .imageURL)
    }
}
