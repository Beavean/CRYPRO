//
//  CoinRowView.swift
//  Crypro
//
//  Created by Beavean on 02.04.2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingsColumn: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn { centralColumn }
            rightColumn
        }
        .font(.subheadline)
        .contentShape(.rect)
    }
}

// MARK: - UI Components

private extension CoinRowView {
    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                Text(coin.name)
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
            }
            .padding(.leading, 6)
        }
    }

    var centralColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text(
                (coin.currentHoldings ?? 0) > 1_000_000
                    ? (coin.currentHoldings ?? 0).formattedWithAbbreviations()
                    : (coin.currentHoldings ?? 0).asNumberString()
            )
        }
        .font(.footnote)
        .foregroundStyle(Color.theme.accent)
    }

    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text((coin.currentPrice ?? 0.0).asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green : Color.theme.red
                )
        }
        .font(.footnote)
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

#Preview {
    CoinRowView(coin: PreviewData.stubCoin, showHoldingsColumn: true)
}
