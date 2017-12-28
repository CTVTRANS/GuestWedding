//
//  MemberViewCell.swift
//  GuestWedding
//
//  Created by le kien on 12/28/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class MemberViewCell: UITableViewCell {

    @IBOutlet weak var nameWoman: UILabel!
    @IBOutlet weak var nameMan: UILabel!
    @IBOutlet weak var dateWoman: UILabel!
    @IBOutlet weak var dateMan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binMember(_ member: Member) {
        dateMan.text = member.dateMan
        dateWoman.text = member.dateWoman
        nameMan.text = member.manName
        nameWoman.text = member.nameWoman
    }
    
}
