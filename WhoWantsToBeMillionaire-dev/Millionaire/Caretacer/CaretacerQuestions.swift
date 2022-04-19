//
//  CaretacerNew.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 02.04.2022.
//

import Foundation

class QuestionsCaretacer {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "questions"
    
    
    func saveQuestion(question: [QuestionAndAnswers]) {
        do {
            let data = try self.encoder.encode(question)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print (error)
        }
    }
    
    func loadQuestions() -> [QuestionAndAnswers] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
           return []
        }
        do  {
            return try self.decoder.decode([QuestionAndAnswers].self, from: data)
        } catch {
            print (error)
            return []
        }
                
        
    }
}
