//
//  IdentifiableError.swift
//  Crypro
//
//  Created by Beavean on 10.05.2024.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id: UUID = .init()
    let message: String
}
