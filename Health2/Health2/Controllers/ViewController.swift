//
//  ViewController.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 02/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    @IBOutlet weak var appointmentsPicker: UIPickerView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var name:String = ""
    var goal:Int = 0
    var goalProgress: Int = 0
    var typesAppointment:[String] = []
    var appointmentsPrice:[Int] = []
    
    var appointments:[String:Any] = [:]
    
    typealias tupleVar = (String, String, String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appointmentsPicker.dataSource = self
        appointmentsPicker.delegate = self
        
        let defaults = UserDefaults.standard
        if let appointmentsTypesPrices = defaults.dictionary(forKey: "appointments") {
            appointments = appointmentsTypesPrices
            transformDictInTwoArrays()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let userDefaults = defaults.stringArray(forKey: "UserDefaults") {
            name = userDefaults[0]
            goal = Int(userDefaults[1])!
            goalProgress = Int(userDefaults[2])!
            welcomeMessageLabel.text = "Olá, \(name)"
            goalProgressLabel.text = "Você já bateu \(goalProgress)/\(goal) da sua meta"
            print("ded")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typesAppointment.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typesAppointment[row]
    }
    
    func appointmentPrice() -> Int {
        let appointmentTypePicker = appointmentsPicker.selectedRow(inComponent: 0)
        return appointmentsPrice[appointmentTypePicker]
    }
    
    func getTextFieldsInput() -> Session {
        // Ler todos os text field
        let appointmentType = Int(self.appointmentType.text!)!
        let session = Session(consultasHoje: appointmentType)
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
    
    
    func returnProfit(session: Session, selectedAppointmentPrice:Int) -> Int{
        let profit = session.consultasHoje * selectedAppointmentPrice
        return profit
    }
    
    func renderProfitAndGoal(profit: Int) {
        showGoal.text = "Hoje você lucrou "
        showLucro.text = "\(String(profit)) reais"
        showProgress.text = "Sua meta é de \(goal) e ainda faltam"
        showGoalLabel.text = "\(goal - goalProgress) reais"
        resultView.isHidden = false
    }
    
    func transformDictInTwoArrays() {
        for (name, price) in appointments{
            typesAppointment.append(name)
            appointmentsPrice.append(price as! Int)
        }
    }
    
    @IBAction func handleNext() {
        let selectedAppointmentPrice = appointmentPrice()
        let sessionObject = getTextFieldsInput()
        let profit = returnProfit(session: sessionObject, selectedAppointmentPrice: selectedAppointmentPrice)
        goalProgress += profit
        let newUserDefaults = [name, String(goal), String(goalProgress)]
        let defaults = UserDefaults.standard
        defaults.set(newUserDefaults, forKey:"UserDefaults")
        hideTextFields()
        // renderProfitAndGoal(profit: Int(profit))
        renderProfitAndGoal(profit: profit)
    }
    
    @IBAction func handleBack(_ sender: Any) {
        appointmentType.text = ""
        showTextFields()
    }
}

