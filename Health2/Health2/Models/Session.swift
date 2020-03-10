//
//  Session.swift
//  Health2
//
//  Created by Pedro da Matta Ribeiro Moura on 10/03/20.
//  Copyright © 2020 Pedro da Matta Ribeiro Moura. All rights reserved.
//

import Foundation

class Session {
    var consultasHoje: Int
    var custoConsulta: Int
    var valorConsulta: Int
    init (consultasHoje: Int, custoConsulta: Int, valorConsulta:Int) {
        self.consultasHoje = consultasHoje
        self.custoConsulta = custoConsulta
        self.valorConsulta = valorConsulta
    }
}
