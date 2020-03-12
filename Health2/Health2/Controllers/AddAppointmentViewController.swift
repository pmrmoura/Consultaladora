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
    
    var dede: [String : Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let defaults = defaults.dictionary(forKey: "appointments") {
            dede = defaults
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        //        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleDone(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(dede, forKey: "appointments")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleAddAppointment(_ sender: Any) {
        let appointmentName = appointmentNameField.text!
        let appointmentPrice = appointmentPriceField.text!
        dede[appointmentName] = Int(appointmentPrice)!
        appointmentNameField.text = ""
        appointmentPriceField.text = ""
    }
}
