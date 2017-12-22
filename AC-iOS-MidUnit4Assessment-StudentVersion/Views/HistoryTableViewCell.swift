//
//  HistoryTableViewCell.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    var cards = [DataModel.History]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var finalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        let nib = UINib(nibName: "CardCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "HistoryCell")
        DataModel.shared.load()
        self.cards = DataModel.shared.getCards()
    }
}
extension HistoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        finalLabel.text = card.handCount.description
        cell.configureHistoryCell(with: card)
        return cell
    }
}
