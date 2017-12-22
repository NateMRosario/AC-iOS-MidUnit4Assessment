//
//  CardCell.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    func configureCell(with card: Card) {
        print(card)
        self.cellLabel.text = CardAPIClient.manager.cardValues(value: card.value).description
        ImageAPIClient.manager.loadImage(from: card.image, completionHandler: {self.cellImageView.image = $0; self.cellImageView.setNeedsLayout()}, errorHandler: {print($0)})
        
    }
}
