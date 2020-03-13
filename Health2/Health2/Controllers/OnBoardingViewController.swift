//
//  OnBoardingViewController.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 09/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    
    var questions:[String] = ["Qual é o seu nome?", "Qual é sua meta mensal?"]
    var answers:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let defaultValues = defaults.array(forKey: "UserDefaults") {
            print(defaultValues)
            UIView.setAnimationsEnabled(false)
            performSegue(withIdentifier: "OnboardingToMain", sender: self)
            UIView.setAnimationsEnabled(true)
        }
    }
    @IBAction func handleNext(_ sender: UIButton) {
        answers.append(questionTextField.text!)
        if (answers.count == 2) {
            let defaults = UserDefaults.standard
            answers.append("0")
            defaults.set(answers, forKey: "UserDefaults")
            performSegue(withIdentifier: "OnboardingToMain", sender: self)
        }
        if (answers.count < 2) {
            questionTextField.placeholder = "Meta mensal"
            questionLabel.text = questions[1]
        }
        
        questionTextField.text = ""
    }
    
}
