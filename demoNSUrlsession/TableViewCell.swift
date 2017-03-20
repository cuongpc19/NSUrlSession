//
//  TableViewCell.swift
//  demoNSUrlsession
//
//  Created by AgribankCard on 3/18/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var leage: UILabel!
    
    @IBOutlet weak var dateMatch: UILabel!
    
    @IBOutlet weak var homeTeam: UILabel!
    
    @IBOutlet weak var goalHome: UILabel!
    
    @IBOutlet weak var goalAway: UILabel!
    
    
    @IBOutlet weak var awayTeam: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
