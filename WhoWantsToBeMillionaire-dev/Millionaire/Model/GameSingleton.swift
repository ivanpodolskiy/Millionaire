//
//  GameSingleton.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

class Game {
    
    weak var currentGame: GameSession?
    private var gameCaretaker = GameCaretacer()
    static var shared = Game()
    
    private init() {
        resultGamesSessions = gameCaretaker.loadResult()
    }
    
    private(set) var resultGamesSessions: [Result] = [] {
        didSet{
            gameCaretaker.saveGameSessionResult(results: resultGamesSessions)
        }
    }
    
    func endGame(){
        guard let numberAll = currentGame?.countQuestion,
              let corectAnswers = (currentGame?.countCorrectAnswer),
              let date = currentGame?.date else { return }
 
        let resultCount: Double = (Double(corectAnswers) / Double(numberAll))*100
        let newResultGame = Result(date: date, resultScore: Int(resultCount))
        resultGamesSessions.append(newResultGame)
        currentGame = nil
    }
}

struct Result: Codable {
    var date: Date
    var resultScore: Int
}


