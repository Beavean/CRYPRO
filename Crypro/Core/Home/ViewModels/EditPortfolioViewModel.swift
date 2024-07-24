//
//  EditPortfolioViewModel.swift
//  Crypro
//
//  Created by Antomated on 23.07.2024.
//

import Foundation
import Combine

final class EditPortfolioViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var detailStatistics: [Statistic] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var filteredCoins: [Coin] = []
    @Published var selectedCoin: Coin?
    private(set) var networkManager: NetworkManaging
    private let allCoins: [Coin]
    private let portfolioDataService: PortfolioDataService
    private var cancellables = Set<AnyCancellable>()

    init(
        selectedCoin: Coin?,
        allCoins: [Coin],
        networkManager: NetworkManaging,
        portfolioDataService: PortfolioDataService
    ) {
        self.selectedCoin = selectedCoin
        self.allCoins = allCoins
        self.filteredCoins = allCoins
        self.networkManager = networkManager
        self.portfolioDataService = portfolioDataService
        addSubscribers()
    }

    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    private func addSubscribers() {
        $selectedCoin
            .map(getCoinDetailStatistics)
            .sink { [weak self] stats in
                guard let self else { return }
                detailStatistics = stats
            }
            .store(in: &cancellables)

        portfolioDataService.$savedEntities
            .map { savedEntities in
                self.mapAllCoinsToPortfolioCoins(allCoins: self.allCoins, portfolioEntities: savedEntities)
            }
            .sink { [weak self] coins in
                guard let self = self else { return }
                self.portfolioCoins = coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
            }
            .store(in: &cancellables)

        $searchText
            .map { query in
                self.filterAndSortCoins(self.allCoins, query: query)
            }
            .sink { coins in
                self.filteredCoins = coins
                if let selectedCoin = self.selectedCoin, !coins.contains(where: { $0.id == selectedCoin.id }) {
                    self.selectedCoin = nil
                }
            }
            .store(in: &cancellables)
    }
}

private extension EditPortfolioViewModel {
    func getCoinDetailStatistics(coin: Coin?) -> [Statistic] {
        guard let coin else { return [] }
        return [
            Statistic(title: LocalizationKey.marketCap.localizedString + ":",
                      value: coin.marketCap?.formattedWithAbbreviations() ?? ""),
            Statistic(title: LocalizationKey.currentPrice.localizedString + ":",
                      value: (coin.currentPrice ?? 0.0).formattedWithAbbreviations()),
            Statistic(title: LocalizationKey.allTimeHigh.localizedString + ":",
                      value: coin.ath?.formattedWithAbbreviations() ?? ""),
            Statistic(title: LocalizationKey.allTimeLow.localizedString + ":",
                      value: coin.atl?.formattedWithAbbreviations() ?? "")
        ]
    }

    func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [Portfolio]) -> [Coin] {
        allCoins.compactMap { coin in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
            var updatedCoin = coin
            updatedCoin.updateHoldings(amount: entity.amount)
            return updatedCoin
        }
    }

    func filterAndSortCoins(_ coins: [Coin], query: String) -> [Coin] {
        guard !query.isEmpty else { return coins }
        let lowerCasedText = query.lowercased()
        var updatedCoins = coins.filter { coin in
            coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
        updatedCoins.sort { $0.rank < $1.rank }
        return updatedCoins
    }
}
