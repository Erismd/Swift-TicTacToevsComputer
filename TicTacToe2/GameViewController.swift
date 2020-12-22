//
//  GameViewController.swift
//  TicTacToe2
//
//  Created by Eri Shimada on 2020/12/21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    @IBOutlet weak var card7: UIImageView!
    @IBOutlet weak var card8: UIImageView!
    @IBOutlet weak var card9: UIImageView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var computerLabel: UILabel!
    
    var playerName: String!
    var currentPlayer = "o"
    
    var playerpickedItems : [Box] = []
    var computerPickedItems : [Box] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        playerLabel.text = playerName + ":"
        
        createTap(on: card1, type: .one)
        createTap(on: card2, type: .two)
        createTap(on: card3, type: .three)
        createTap(on: card4, type: .four)
        createTap(on: card5, type: .five)
        createTap(on: card6, type: .six)
        createTap(on: card7, type: .seven)
        createTap(on: card8, type: .eight)
        createTap(on: card9, type: .nine)

        // Do any additional setup after loading the view.
    }
    
    func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.cardClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func cardClicked(_ sender: UITapGestureRecognizer){
        let selectedCard = getCard(from: sender.name ?? "")
//        let imageName = "close.png"
//        selectedCard.image = UIImage(named: imageName)
        pickCard(selectedCard)
        playerpickedItems.append(Box(rawValue: sender.name!)!)
        checkWinner()
        
        //delay the computer turn
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.computerMove()
        }
    }
    
    func computerMove() {
        var emptySpace = [UIImageView]()
        var availableCards = [Box]()
        
        for name in Box.allCases {
            let card = getCard(from: name.rawValue)
            if card.image == nil {
                emptySpace.append(card)
                availableCards.append(name)
            }
        }
        
        guard availableCards.count > 0 else { return }
        
        let randomIndex = Int.random(in: 0 ..< emptySpace.count)
        pickCard(emptySpace[randomIndex])
        computerPickedItems.append(availableCards[randomIndex])
        checkWinner()
    }
    
    func pickCard(_ selectedCard: UIImageView){
        guard selectedCard.image == nil else {
            return
        }
        
        if currentPlayer == "x"{
            let circle = "circle.png"
            selectedCard.image = UIImage(named: circle)
            currentPlayer = "o"
        }else{
            let close = "close.png"
            selectedCard.image = UIImage(named: close)
            currentPlayer = "x"
        }
    }
    
    func checkWinner() {
        var correct = [[Box]]()
        let topRow : [Box] = [.one, .two, .three]
        let middleRow : [Box] = [.four, .five, .six]
        let buttomRow : [Box] = [.seven, .eight, .nine]
        
        let firstCollumn : [Box] = [.one, .four, .seven]
        let secontCollumn : [Box] = [.two, .five, .eight]
        let thirdCollumn : [Box] = [.three, .six, .nine]
        
        let slash : [Box] = [.three, .five, .seven]
        let backSlash : [Box] = [.three, .five, .seven]
        
        correct.append(topRow)
        correct.append(middleRow)
        correct.append(buttomRow)
        correct.append(firstCollumn)
        correct.append(secontCollumn)
        correct.append(thirdCollumn)
        correct.append(slash)
        correct.append(backSlash)
        
        for valid in correct {
            let userMatch = playerpickedItems.filter{ valid.contains($0)}.count
            let computerMatch = computerPickedItems.filter{ valid.contains($0)}.count
            
            if userMatch == valid.count {
                playerLabel.text = "Player : " + String((Int(playerLabel.text ?? "0") ?? 0) + 1)
                resetGame()
                break
            }else if computerMatch == valid.count {
                computerLabel.text = "Computer : " + String((Int(computerLabel.text ?? "0") ?? 0) + 1)
                resetGame()
                break
            }else if computerPickedItems.count + playerpickedItems.count == 9 {
                resetGame()
                break
                
            }
        }
        
    }
    
    func resetGame(){
        for name in Box.allCases {
            let card = getCard(from: name.rawValue)
            card.image = nil
        }
        currentPlayer = "o"
        playerpickedItems = []
        computerPickedItems = []
    }
    
    func getCard(from name: String) -> UIImageView {
        let card = Box(rawValue: name) ?? .one
        
        switch card {
        case .one:
            return card1
        case .two:
            return card2
        case .three:
            return card3
        case .four:
            return card4
        case .five:
            return card5
        case .six:
            return card6
        case .seven:
            return card7
        case .eight:
            return card8
        case .nine:
            return card9
        }
    }
    
    
    enum Box: String, CaseIterable {
        case one, two, three, four, five, six, seven, eight, nine
    }
    

}
