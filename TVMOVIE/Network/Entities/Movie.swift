//
//  Moview.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/22/24.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int
    let results: [Movie]
    
    enum CodingKeys: CodingKey {
        case page
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}

struct Movie: Decodable, Hashable {
    let title: String
    let overview: String
    let posterURL: String
    let vote: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        let path = try container.decode(String.self, forKey: .posterPath)
        self.posterURL = "https://image.tmdb.org/t/p/w500\(path)"
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}
