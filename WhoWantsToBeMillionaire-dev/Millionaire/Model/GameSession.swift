//
//  GameSession.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

protocol GameSessionDelegat: AnyObject {
    func loadResult()
}

protocol GameSassionProtocol {
    var countCorrectAnswer: Int { get }
    var money: Observable<Int> { get }
    var countQuestion: Int {get }
    var questionsSequence: QuestionsSequence { get }
    var currentNumberQuestion: Observable<Int> {get }
    
    var resultCount: Observable<Int> { get }
    
    init()
    
}

class GameSession: GameSassionProtocol {
    var currentNumberQuestion = Observable<Int>(1)
    weak var delegate: GameSessionDelegat?
    var money = Observable<Int>(0)
    var date: Date = Date()
    var countCorrectAnswer: Int = 0
    var countQuestion: Int = 0
    var questionsSequence: QuestionsSequence = .direct
    
    var resultCount = Observable<Int>(0)
    
    required internal init(){
        self.countQuestion = Game.shared.questions.count
    }
}

extension GameSession: GameSessionDelegat {
    func loadResult() {
        self.countCorrectAnswer += 1
        if currentNumberQuestion.value != countQuestion  {
            self.currentNumberQuestion.value += 1
        }
        self.money.value += 1000000 / countQuestion
        self.resultCount.value = Int((Double(countCorrectAnswer) / Double(countQuestion)) * 100)
    }
}

