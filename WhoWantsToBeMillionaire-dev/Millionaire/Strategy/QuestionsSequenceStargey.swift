//
//  Strategy.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 29.03.2022.
//

import Foundation
protocol QuestionsSequenceStargey {
    func questionsSequence() -> [QuestionAndAnswersProtocol]
}

class RandomQuestionsSequenceStargey: QuestionsSequenceStargey {
    func questionsSequence() -> [QuestionAndAnswersProtocol] {
        let arryQuestuionsSort = Game.shared.loadQuestions().shuffled()
        return arryQuestuionsSort
    }
}

class DirectQuestionsSequencseStrategy: QuestionsSequenceStargey {
    func questionsSequence() -> [QuestionAndAnswersProtocol] {
        let arryQuestuions = Game.shared.loadQuestions()
        return arryQuestuions
    }
}

