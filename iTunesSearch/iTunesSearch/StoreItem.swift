//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Duliba Sviatoslav on 11.05.2022.
//

import Foundation

struct StoreItem: Codable {
    let trackName: String
    let artistName: String
    var kind: String
    var description: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case kind
        case description = "longDescription"
        case artworkURL = "artworkUrl100"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
    artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
    kind = try values.decode(String.self, forKey: CodingKeys.kind)
    artworkURL = try values.decode(URL.self, forKey:
       CodingKeys.artworkURL)
    
    if let description = try? values.decode(String.self,
       forKey: CodingKeys.description) {
        self.description = description
    } else {
        let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
        description = (try? additionalValues.decode(String.self,forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}




