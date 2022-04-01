//
//  Strategy.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 29.03.2022.
//

import Foundation
protocol QuestionsGeneratorStrategy {
    func geneationQuestions(with questions: [QuestionAndAnswersProtocol]) -> [String] 
}

class RandomQuestionsGeneratorStrategy: QuestionsGeneratorStrategy {
    func geneationQuestions(with questions: [QuestionAndAnswersProtocol]) -> [String] {
        
        let randomIndex = Int.random(in: 0..<questions.count)
        guard let model = questions[randomIndex] as? QuestionAndAnswers else {
            return []
        }
      
    
        let correctAnswer = model.correctAnswer
        let secondA = model.secondAnswer
        let thirdA = model.thirdAnswer
        let fourthA = model.fourthAnswer
        
        print ("Правельный ответ: \(correctAnswer)")
        let arryAnswer = [correctAnswer, secondA, thirdA, fourthA]
        return arryAnswer
    }
}
