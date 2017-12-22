//
//  ViewController.swift
//  AC-iOS-MidUnit4Assessment-StudentVersion
//
//  Created by C4Q  on 12/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var countIndex = 0
    var winningNum = 30
    var currentHand = 0 {
        didSet {
            if currentHand == winningNum {
                alertController(title: "Winner!", message: "You Won!")
            } else if currentHand > winningNum {
                alertController(title: "Game Over", message: "You went over \(winningNum)!")
            }
            collectionView.reloadData()
        }
    }
    var deckOfCards: CardDeck?
    
    var cards = [Card]() {
        didSet {
            collectionView.reloadData()
            if cards.count >= 1 {
                currentHand += CardAPIClient.manager.cardValues(value: cards[countIndex].value)
                countIndex += 1
                currentValueLabel.text = currentHand.description
            }
        }
    }
    
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        alertController(title: "Game Over", message: "You were \(winningNum - currentHand) away from \(winningNum)")
    }
    @IBAction func drawButtonPressed(_ sender: UIButton) {
        loadCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        rulesLabel.text = "Get up to 30 without going over!"
        let nib = UINib(nibName: "CardCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        loadDeck()
    }
    func resetGame() {
        loadDeck()
        cards = [Card]()
        currentHand = 0
        countIndex = 0
        currentValueLabel.text = currentHand.description
    }
    func loadDeck() {
        CardAPIClient.manager.getDeck(completion: {self.deckOfCards = $0}, errorHandler: {print($0)})
    }
    func loadCards() {
        guard let id = deckOfCards?.deck_id else {return}
        CardAPIClient.manager.getCard(deckId: id , completion: {self.cards += $0}, errorHandler: {print($0)})
    }
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Game", style: .cancel) {(action:UIAlertAction!) in
            self.resetGame()
    })
        self.present(alert, animated: true, completion: nil)
    }
    

}
extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell else {return UICollectionViewCell()}
        let card = cards[indexPath.row]
            cell.configureCell(with: card)
        return cell
    }
}
