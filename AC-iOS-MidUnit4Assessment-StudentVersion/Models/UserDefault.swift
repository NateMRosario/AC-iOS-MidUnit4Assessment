//
//  UserDefault.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct UserDefaultHelper {
    private init() {}
    static let manager = UserDefaultHelper()
    private let CardKey = "Card"
    func getWinningNum() -> Int? {
        return UserDefaults.standard.integer(forKey: CardKey)
    }
    func setWinningNumber(to newBook: Int) {
        UserDefaults.standard.setValue(newBook, forKey: CardKey)
    }
}
