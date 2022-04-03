//
//  QuestionsFacade.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 01.04.2022.
//

import Foundation

enum QuestionsSequence {
    case direct, random
}

class QuestionsFacade {
    var sequence: QuestionsSequence
    
    init(sequence: QuestionsSequence) {
        self.sequence = sequence
    }
    
    private var questionsSequence: QuestionsSequenceStargey {
        switch sequence {
        case .direct:
            return DirectQuestionsSequencseStrategy()
        case .random:
            return RandomQuestionsSequenceStargey()
        }
    }
    
    func questionsSequenceGeneration() -> [QuestionAndAnswersProtocol] {
        return questionsSequence.questionsSequence()
    }
}
