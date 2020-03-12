//
//  AddAppointmentViewController.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 12/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import UIKit

class AddAppointmentViewController: UIViewController {
    @IBOutlet weak var appointmentNameField: UITextField!
    @IBOutlet weak var appointmentPriceField: UITextField!
    
    var dede = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(dede, forKey: "appointments")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        //        self.dismiss(animated: true, completion: nil)
        let defaults = UserDefaults.standard
        if let appointments = defaults.dictionary(forKey: "appointments") {
            print(appointments)
        }
    }
    
    @IBAction func handleAddAppointment(_ sender: Any) {
        let appointmentName = appointmentNameField.text!
        let appointmentPrice = appointmentPriceField.text!
        
    }
}
