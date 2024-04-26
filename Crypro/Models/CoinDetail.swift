//
//  CoinDetail.swift
//  Crypro
//
//  Created by Anton Petrov on 06.04.2024.
//

import Foundation

struct CoinDetails: Decodable {
    let id: String?
    let symbol: String?
    let name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let description: Description?
    let links: Links?

    var readableDescription: String? {
        description?.en?.removingHTMLOccurrences
    }
}

struct Description: Decodable {
    let en: String?
}

struct Links: Decodable {
    let homepage: [String]?
    let subredditURL: String?
    private let twitterScreenName: String?
    private let telegramChannelIdentifier: String?

    var twitterURL: String? {
        guard let screenName = twitterScreenName, !screenName.isEmpty else { return nil }
        return "https://twitter.com/\(screenName)"
    }

    var telegramURL: String? {
        guard let identifier = telegramChannelIdentifier, !identifier.isEmpty else { return nil }
        return "https://t.me/\(identifier)"
    }
}
