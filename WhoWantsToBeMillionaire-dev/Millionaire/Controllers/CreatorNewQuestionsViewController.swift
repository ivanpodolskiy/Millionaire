//
//  CreatorNewQuestionsViewController.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 02.04.2022.
//

import UIKit

class CreatorNewQuestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var question: UITextField!
    
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var wrongAnswerFirst: UITextField!
    @IBOutlet weak var wrongAnswerSecond: UITextField!
    @IBOutlet weak var wrongAnswerThrid: UITextField!

    @IBAction func exitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateNewQuestion(_ sender: UIButton){
        guard let questions = question.text, let firstA = correctAnswer.text, let secondA = wrongAnswerFirst.text, let thirdA = wrongAnswerSecond.text, let fourthA = wrongAnswerThrid.text else {
            return
        }
        Game.shared.saveQuestions(q: questions, a1: firstA, a2: secondA, a3: thirdA, a4: fourthA)
        showAlert(question: questions)
        
        self.question.text = nil
        self.correctAnswer.text = nil
        self.wrongAnswerFirst.text = nil
        self.wrongAnswerSecond.text = nil
        self.wrongAnswerThrid.text = nil
    }
    
    func showAlert(question title: String) {
        let alertController = UIAlertController(title: "Вы добавили новый вопрос", message: (title), preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(actionAlert)
        present(alertController, animated: true, completion: nil)
    }
}
