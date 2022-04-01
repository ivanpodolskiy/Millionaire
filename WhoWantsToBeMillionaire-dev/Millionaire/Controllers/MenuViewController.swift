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
   
    //Загружаем текст в Label
    func updateLable() {
        guard let model = Game.shared.resultGamesSessions.last else {
            return
        }
        lastResultLabel.text = "Последняя игра:\(dateFormatter.string(from: model.date))  Правельных ответов: \(model.resultScore)%"
    }
}
