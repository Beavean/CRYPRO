//
//  LinkView.swift
//  Crypro
//
//  Created by Beavean on 20.04.2024.
//

import SwiftUI

struct LinkView: View {
    let title: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            HStack(spacing: 0) {
                SystemImage.linkIcon.image
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.theme.background)
                Text(title)
                    .padding(.leading, 6)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.theme.background)
            }
        }
        .padding(7)
        .padding(.horizontal, 6)
        .background(Capsule().fill(Color.theme.accent))
    }
}

#Preview {
    LinkView(title: LocalizationKey.website.localizedString,
             url: URL(string: Constants.twitterBaseUrl)!)
}
