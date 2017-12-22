//
//  DataModel.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    
    private init() {}
    static let shared = DataModel()
    
    static let kPathName = "RecentCardGames.plist"
    
    struct History: Codable {
        let handCount: Int
        let image: String
        let value: String
    }
    private var savedCards = [History]() {
        didSet {
            saveCardList()
        }
    }
    //returns documents directory path for the app
    public func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    //returns sipplied path name in documents directory
    public func dataFilePath(pathName: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(pathName)
    }
    
    func addCard(cards: [Card], handCount: Int) {
        for card in cards {
        let cardList = History(handCount: handCount, image: card.image, value: card.value)
        savedCards.append(cardList)
        }
    }
    
    private func saveCardList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedCards)
            try data.write(to: dataFilePath(pathName: DataModel.kPathName), options: .atomic)
        } catch {
            print("error encoding items: \(error.localizedDescription)")
        }
    }
    
    //load
    func load() {
        let path = DataModel.shared.dataFilePath(pathName: DataModel.kPathName).path
        if let results = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [History] {
            savedCards = results
        }
    }
    //create
    func addCardItemToList(cardItem item: History) {
        savedCards.append(item)
    }
    //read
    func getCards() -> [History] {
        return savedCards
    }
    
    //update
    
    
    //delete
    public func removeHistoryItem() {
        savedCards.removeAll()
    }
}

