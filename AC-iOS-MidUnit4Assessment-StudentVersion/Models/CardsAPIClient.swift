//
//  CardsAPIClient.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

///Deck
struct CardDeck: Codable {
    let deck_id: String
}

///Draw
struct DrawnCard: Codable {
    let cards: [Card]
}
struct Card: Codable {
    let image: String
    let value: String
}

///Deck: https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6
///Draw: https://deckofcardsapi.com/api/deck/<<deck_id>>/draw/?count=1

struct CardAPIClient {
    private init() {}
    static let manager = CardAPIClient()
    func getDeck(completion: @escaping (CardDeck) -> Void, errorHandler: @escaping (Error) -> Void) {
        let deckURL = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6"
        guard let url = URL(string: deckURL) else {
            errorHandler(AppError.badURL(str: deckURL))
            return
        }
        let request = URLRequest(url: url)
        let bookData: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode(CardDeck.self, from: data)
                let deck = results
                completion(deck)
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: bookData, errorHandler: errorHandler)
    }
    func getCard(deckId: String, completion: @escaping ([Card]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let cardURL = "https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=1"
        guard let url = URL(string: cardURL) else {
            errorHandler(AppError.badURL(str: cardURL))
            return
        }
        let request = URLRequest(url: url)
        let bookData: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode(DrawnCard.self, from: data)
                let card = results.cards
                completion(card)
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: bookData, errorHandler: errorHandler)
    }
    func cardValues(value: String) -> Int {
        var number = 0
        switch value {
        case "2":
            number = 2
        case "3":
            number = 3
        case "4":
            number = 4
        case "5":
            number = 5
        case "6":
            number = 6
        case "7":
            number = 7
        case "8":
            number = 8
        case "9":
            number = 9
        case "10":
            number = 10
        case "KING", "QUEEN", "JACK":
            number = 10
        case "ACE":
            number = 11
        default:
            break
        }
        return number
    }
}


