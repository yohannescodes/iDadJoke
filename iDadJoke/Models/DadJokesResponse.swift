//
//  DadJokesResponse.swift
//  iDadJoke
//
//  Created by Yohannes Haile on 9/13/22.
//

import Foundation

// MARK: - DadJoke
class DadJokeResponse: Codable {
    let body: [Body]
    let success: Bool

    init(body: [Body], success: Bool) {
        self.body = body
        self.success = success
    }
}

// MARK: - Body
class Body: Codable {
    let id, punchline, setup, type: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case punchline, setup, type
    }

    init(id: String, punchline: String, setup: String, type: String) {
        self.id = id
        self.punchline = punchline
        self.setup = setup
        self.type = type
    }
}
