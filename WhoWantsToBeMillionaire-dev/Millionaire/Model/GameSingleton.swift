//
//  GameSingleton.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

class Game {
    
    //MARK: - Questions
    
    private var questionsCaretaker = QuestionsCaretacer()
    
    private(set) var questions: [QuestionAndAnswers] = [] {
        didSet {
            questionsCaretaker.saveQuestion(question: questions)
        }
    }
    
    func saveQuestions(q: String, a1: String, a2: String, a3: String, a4: String) {
        let newQuestions = (QuestionAndAnswers(question: q, correctAnswer: a1, secondAnswer: a2, thirdAnswer: a3, fourthAnswer: a4))
        questions.insert(newQuestions, at: 0)
    }
    
    func loadQuestions() -> [QuestionAndAnswers] {
        return questions
    }
    
    //MARK: - Game
    
    weak var currentGame: GameSession?
    private var gameCaretaker = GameCaretacer()
   
    static var shared = Game()
    
    private var questionsSequence: QuestionsSequence
    
    private init() {
        questions = questionsCaretaker.loadQuestions()
        resultGamesSessions = gameCaretaker.loadResult()
        questionsSequence = currentGame?.questionsSequence ?? .direct
    }
    
   
    
    private(set) var resultGamesSessions: [Result] = [] {
        didSet{
            gameCaretaker.saveGameSessionResult(results: resultGamesSessions)
        }
    }
    
    func endGame(){
        guard let numberAll = currentGame?.countQuestion,
              let corectAnswers = (currentGame?.countCorrectAnswer),
              let date = currentGame?.date
//              let questionsSequence = currentGame?.questionsSequence
        else
                { return }
        
        
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


