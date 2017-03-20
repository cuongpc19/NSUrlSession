//
//  Match.swift
//  demoNSUrlsession
//
//  Created by AgribankCard on 3/18/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
class Match {
    var leage: String?
    var date : String?
    var homeTeam: String?
    var awayTeam: String?
    var goalsHomeTeam: String?
    var goalsAwayTeam: String?
    init?() {
    }
    init(leage: String?,date: String, homeTeam: String, awayTeam: String, goalsHomeTeam : String,goalsAwayTeam: String ) {
        self.leage = leage
        self.date = date
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.goalsAwayTeam = goalsAwayTeam
        self.goalsHomeTeam = goalsHomeTeam
    }
    
}
