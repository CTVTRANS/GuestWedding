//
//  LeftMenuViewController.swift
//  GuestWedding
//
//  Created by Kien on 10/31/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {
    
    @IBOutlet weak var viewOfNotice: UIView!
    @IBOutlet weak var numberNotice: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        viewOfNotice.isHidden = true
    }
    
    func binData(name: String, index: Int) {
        self.name.text = name
    }
}

class LeftMenuViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    var arrayMenu = ["row 1", "row2", "row3", "row4", "row5", "row6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeftMenuCell
        cell?.binData(name: arrayMenu[indexPath.row], index: indexPath.row)
        return cell!
    }
}
