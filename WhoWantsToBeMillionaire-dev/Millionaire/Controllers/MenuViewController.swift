//
//  ManuViewController.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLable()
    }
  
    @IBOutlet weak var lastResultLabel: UILabel!
   
    @IBOutlet weak var sequenceControl: UISegmentedControl!
    
    func updateLable() {
        guard let model = Game.shared.resultGamesSessions.last else {
            return
        }
        lastResultLabel.text = "Последняя игра:\(dateFormatter.string(from: model.date))  Правельных ответов: \(model.resultScore)%"
    }
    
    private var selectedSequence: QuestionsSequence {
        switch sequenceControl.selectedSegmentIndex {
        case 0:
            return .direct
        case 1:
            return .random
            
        default:
            return .random
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toGameScene":
            guard let destinatin = segue.destination as? GameViewController else {
                return
            }
            Game.shared.currentGame = destinatin.gameSession
            destinatin.questionsSequence = selectedSequence
        default:
            break
        }
   
    }
}
