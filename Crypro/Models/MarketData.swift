//
//  MarketData.swift
//  Crypro
//
//  Created by Antomated on 03.04.2024.
//

import Foundation

struct GlobalCryptoMarketData: Decodable {
    let data: MarketData
}

struct MarketData: Decodable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let activeCryptocurrencies: Int
    let markets: Int
    let endedIcos: Int
    let ongoingIcos: Int

    var marketCap: String {
        guard let item = totalMarketCap.first(where: { $0.key == "usd" }) else { return "" }
        return item.value.asCurrencyWithAbbreviations()
    }

    var volume: String {
        guard let item = totalVolume.first(where: { $0.key == "usd" }) else { return "" }
        return item.value.asCurrencyWithAbbreviations()
    }

    var btcDominance: String {
        guard let item = marketCapPercentage.first(where: { $0.key == "btc" }) else { return "" }
        return item.value.asPercentString()
    }

    var ethDominance: String {
        guard let item = marketCapPercentage.first(where: { $0.key == "eth" }) else { return "" }
        return item.value.asPercentString()
    }
}
