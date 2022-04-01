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
    
    //Начало. Передаем делегат и передаем GameSession в Singleton
    func start() {
        //Добавляем вопросы и ответы в массив allQuestion
        questionStrage.getQuestions().forEach { q in
            allQuestion.append(q)
            print(allQuestion)
        }
        //Добавляем кнопки в массив arryButton
        self.arryButton.append(self.firstAnswerButton)
        self.arryButton.append(self.secondAnswerButton)
        self.arryButton.append(self.thirdAnswerButton)
        self.arryButton.append(self.fourthAnswerButton)
        countQuestions = allQuestion.count
        Game.shared.currentGame = gameSession
        self.delegat = gameSession
    }
    
    
    weak var delegat: GameSessionDelegat?
    var gameSession  = GameSession()
    var questionStrage = QuestionStorage()
    var allQuestion: [QuestionAndAnswersProtocol] = []
    
    //Вспомогательные свойства
    var correctAnswer: String = ""
    var countQuestions: Int = 0
    var womMoney: Int = 0
    var countСorrectAnswers: Int = 0
    var question: String = ""
    var arryButton: [UIButton] = []
    var numberQ: Int = 0
    
    //Обновление результатов
    func updateResult() {
        self.womMoney += 1000000 / countQuestions
        self.countСorrectAnswers += 1
        self.countMoneyInBankLable.text = "Ваш банк: \(womMoney)"
    }
    
 

    //Проверка ответа
    func examinationAnswer(sender: UIButton) {
        if sender.titleLabel?.text == correctAnswer {
            updateResult()
            print ("Ответили правильн")
            updateUI()
        } else {
            print ("Ответили не правльно")
            self.showAler(title: "Вы проиграли :(")
            delegat?.loadResult(correctAnswes: countСorrectAnswers, countQuestion: countQuestions, wonMoney: womMoney)
            Game.shared.endGame()
        }
    }
    
    //Обновленеи UI
    func updateUI(){
        //Проверяем массив allQuestion
        if allQuestion.count == 0 {
            //Передаем данные в делегат и удаляем GameSession из Singleton
            delegat?.loadResult(correctAnswes: countСorrectAnswers, countQuestion: countQuestions, wonMoney: womMoney)
            Game.shared.endGame()
            showAler(title: "Вы выграли")
        } else {
            let randomIndex = Int.random(in: 0..<allQuestion.count)
            guard let model = allQuestion[randomIndex] as? QuestionAndAnswers else {
                return
            }
            numberQ += 1
            self.numberQuestionLabel.text  = "Вопрос №\(numberQ)"
            self.correctAnswer = model.correctAnswer
            self.questionLabel.text = model.question
            let secondA = model.secondAnswer
            let thirdA = model.thirdAnswer
            let fourthA = model.fourthAnswer
            
            print ("Правельный ответ: \(correctAnswer)")
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
            //Удалем использованный вопрос из массива allQuestion
            allQuestion.remove(at: randomIndex)
        }
    }
    
    //Алерт
    func showAler(title: String) {
        let alertController = UIAlertController(title: title, message: "Вы ответили правильно: \(countСorrectAnswers) раз. Ваш банк: \(womMoney)", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(actionAlert)
        present(alertController, animated: true, completion: nil)
    }

    
}
