//
//  DetailLoadingView.swift
//  Crypro
//
//  Created by Antomated on 07.06.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    var coin: Coin?
    private(set) var portfolioDataService: PortfolioDataServiceProtocol
    private(set) var networkManager: NetworkServiceProtocol

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin, portfolioDataService: portfolioDataService, networkManager: networkManager)
            }
        }
    }
}
