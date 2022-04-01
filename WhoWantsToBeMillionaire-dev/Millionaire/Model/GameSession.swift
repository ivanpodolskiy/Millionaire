//
//  GameSession.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

protocol GameSessionDelegat: AnyObject {
    func loadResult(correctAnswes: Int,countQuestion: Int, wonMoney: Int)
}

protocol GameSassionProtocol {
    var countCorrectAnswer: Int { get }
    var money: Int { get }
    var countQuestion: Int {get }
}

class GameSession: GameSassionProtocol {
    weak var delegate: GameSessionDelegat?
    var money: Int = 0
    var date: Date = Date()
    var countCorrectAnswer: Int = 0
    var countQuestion: Int = 0
}

extension GameSession: GameSessionDelegat {
    func loadResult(correctAnswes: Int,countQuestion: Int, wonMoney: Int) {
        self.countQuestion = countQuestion
        self.countCorrectAnswer = correctAnswes
        self.money = wonMoney
    }
}
