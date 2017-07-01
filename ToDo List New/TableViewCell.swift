//
//  TableViewCell.swift
//  ToDo List New
//
//  Created by Kushagra Saxena on 29/06/17.
//  Copyright © 2017 Kushagra Saxena. All rights reserved.
//

import UIKit

protocol toggleSwitch {
    func CellSwitchToggleON(info:TableViewCell)
    func CellSwitchToggleOFF(info:TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    var delegate:toggleSwitch? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBOutlet weak var listInfoLabel: UILabel!
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        if(sender.isOn)
        {delegate!.CellSwitchToggleON(info: self)}
        else
        {delegate!.CellSwitchToggleOFF(info: self)}
        
    }
    
    
}
