//
//  TV.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/22/24.
//

import Foundation

struct TVListModel: Decodable {
    let page: Int
    let results: [TV]
    
    enum CodingKeys: CodingKey {
        case page
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([TV].self, forKey: .results)
    }
}


struct TV: Decodable, Hashable {
    let name: String
    let overview: String
    let posterURL: String
    let vote: String
    let firstAirDate: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decode(String.self, forKey: .overview)
        let path = try container.decode(String.self, forKey: .posterPath)
        self.posterURL = "https://image.tmdb.org/t/p/w500\(path)"
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"
        self.firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
    }
}
