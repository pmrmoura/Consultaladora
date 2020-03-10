//
//  ViewController.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 02/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    
    @IBOutlet weak var appointmentType: UITextField!
    @IBOutlet weak var appointmentCost: UITextField!
    @IBOutlet weak var appointmentValue: UITextField!
    
    @IBOutlet weak var appointmentTypeLabel: UILabel!
    @IBOutlet weak var appointmentCostLabel: UILabel!
    @IBOutlet weak var appointmentValueLabel: UILabel!
    
    @IBOutlet weak var showGoal: UILabel!
    @IBOutlet weak var showLucro: UILabel!
    @IBOutlet weak var showGoalLabel: UILabel!
    @IBOutlet weak var showProgress: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var goal:Int = 0
    var goalProgress: Int = 0
    
    typealias tupleVar = (String, String, String)
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let userDefaults = defaults.stringArray(forKey: "UserDefaults") {
            name = userDefaults[0]
            goal = Int(userDefaults[1])!
            goalProgress = Int(userDefaults[2])!
            
            print(goalProgress)
            welcomeMessageLabel.text = "Olá, \(name)"
            goalProgressLabel.text = "Você já bateu \(goalProgress)/\(goal) da sua meta"
        }
    }
    
    func getTextFieldsInput() -> Session {
        // Ler todos os text field
        let appointmentType = Int(self.appointmentType.text!)!
        let custoConsulta = Int(self.appointmentCost.text!)!
        let valorConsulta = Int(self.appointmentValue.text!)!
        let session = Session(consultasHoje: appointmentType, custoConsulta: custoConsulta, valorConsulta: valorConsulta)
        return session
    }
    
    func saveValues(_ profitOfDay: String){
        // Salva os valores do textfield
        self.goalProgress -= Int(profitOfDay)!
    }
    
    func hideTextFields() {
        // Desaparece todos os textfields da tela inicial
        mainView.isHidden = true
    }
    
    func showTextFields() {
        mainView.isHidden = false
        resultView.isHidden = true
        goalProgressLabel.text = "Você já bateu \(goalProgress)/\(goal) da sua meta"
    }
    
    
    func returnProfit(session: Session) -> Int{
        // Multiplica o valor guardado no textfield de consultas pelo Valor
        // menos o custo
        let appointmentNumberInt =  session.consultasHoje
        let valueInt = session.valorConsulta
        let costInt = session.custoConsulta
        let profit = appointmentNumberInt * (valueInt - costInt)
        return profit
    }
    
    func renderProfitAndGoal(profit: Int) {
        showGoal.text = "Hoje você lucrou "
        showLucro.text = "\(String(profit)) reais"
        showProgress.text = "Sua meta é de \(goal) e ainda faltam"
        showGoalLabel.text = "\(goal - goalProgress) reais"
        resultView.isHidden = false
    }
    
    
    @IBAction func handleNext() {
        let sessionValues = getTextFieldsInput()
        let profit = returnProfit(session: sessionValues)
        goalProgress += profit
        let newUserDefaults = [name, String(goal), String(goalProgress)]
        let defaults = UserDefaults.standard
        defaults.set(newUserDefaults, forKey:"UserDefaults")
        hideTextFields()
        renderProfitAndGoal(profit: Int(profit))
    }
    
    @IBAction func handleBack(_ sender: Any) {
        appointmentType.text = ""
        appointmentCost.text = ""
        appointmentValue.text = ""
        showTextFields()
    }
}

