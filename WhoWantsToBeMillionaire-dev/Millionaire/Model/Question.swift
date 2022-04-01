//
//  q.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

protocol  QuestionAndAnswersProtocol {
    var question: String {get }
    var correctAnswer: String {get}
    var secondAnswer: String {get}
    var thirdAnswer: String {get }
    var fourthAnswer: String {get}
}

struct QuestionAndAnswers: QuestionAndAnswersProtocol {
    var question: String
    var correctAnswer: String
    var secondAnswer: String
    var thirdAnswer: String
    var fourthAnswer: String
}
