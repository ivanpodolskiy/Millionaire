//
//  GameViewController.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.facade = QuestionsFacade(sequence: questionsSequence ?? .random)
        self.start()
        self.updateUI()
    }
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    

    @IBOutlet weak var numberQuestionLabel: UILabel!
    @IBOutlet weak var countMoneyInBankLable: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func examinationAction(_ sender: UIButton) {
        self.examinationAnswer(sender: sender)
    }
    
    @IBOutlet weak var coutCorrectAnswer: UILabel!
    
    
    //Начало. Передаем делегат и передаем GameSession в Singleton
    func start() {
        guard let arrySortQuestions = facade?.questionsSequenceGeneration() else {
            return
        }
        self.allQuestion  = arrySortQuestions
        
        //Добавляем кнопки в массив arryButton
        self.arryButton.append(self.firstAnswerButton)
        self.arryButton.append(self.secondAnswerButton)
        self.arryButton.append(self.thirdAnswerButton)
        self.arryButton.append(self.fourthAnswerButton)
        self.delegat = gameSession
        Game.shared.currentGame?.money.addObserver(self, options: [.initial, .new]) {  money,ch  in
            self.countMoneyInBankLable.text = "Ваш банк: \(money)"
        }
        
        Game.shared.currentGame?.currentNumberQuestion.addObserver(self, options: [.initial, .new]) { number,ch in
            self.numberQuestionLabel.text = "Вопрос №\(number)"
        }
        
        Game.shared.currentGame?.resultCount.addObserver(self, options: [.initial, .new]) { count, ch in
            self.coutCorrectAnswer.text = ("Правельных ответов \(count)%")
        }
    }
    
    var facade: QuestionsFacade?
    var questionsSequence: QuestionsSequence?
    
    weak var delegat: GameSessionDelegat?
    var gameSession  = GameSession()
    
    var allQuestion: [QuestionAndAnswersProtocol] = []
    
    //Вспомогательные свойства
    var correctAnswer: String = ""
    var numberQ: Int = 0
    var arryButton: [UIButton] = []
    

    //Проверка ответа
    func examinationAnswer(sender: UIButton) {
        if sender.titleLabel?.text == correctAnswer {
            delegat?.loadResult()
            updateUI()
        } else {
            self.showAler(title: "Вы проиграли :(")
        }
    }
    
    //Обновленеи UI
    func updateUI(){
        if numberQ == allQuestion.count {
            showAler(title: "Вы выграли")
        } else {
            guard let model = allQuestion[numberQ] as? QuestionAndAnswers else {
                return
            }
            self.questionLabel.text = model.question
            
            self.correctAnswer = model.correctAnswer
            let secondA = model.secondAnswer
            let thirdA = model.thirdAnswer
            let fourthA = model.fourthAnswer
            var arryAnswer = [correctAnswer, secondA, thirdA, fourthA]
            
            var i = 3
            while i > 0 {
                arryButton.forEach { button in
                    let index = Int.random(in: 0..<arryAnswer.count)
                    button.setTitle(arryAnswer[index], for: .normal)
                    arryAnswer.remove(at: index)
                    i -= 1
                    print (i)
                }
            }
            numberQ += 1
        }
    }
    
    func showAler(title: String) {
        guard let money = Game.shared.currentGame?.money.value, let countСorrectAnswers =  Game.shared.currentGame?.countCorrectAnswer else {
            return
        }
        let alertController = UIAlertController(title: title, message: "Вы ответили правильно: \(countСorrectAnswers) раз. Ваш банк: \(money)", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(actionAlert)
        present(alertController, animated: true, completion: {
            Game.shared.endGame()
        })
    }

    
}
