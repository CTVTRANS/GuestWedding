//
//  SearchMember.swift
//  GuestWedding
//
//  Created by le kien on 12/27/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import Foundation
import UIKit

class SearchMember: BaseDailog {
   
    @IBOutlet weak var table: UITableView!
    var listmember = [Member]()
    var memberSlect: Member?
    var callBack:((_ member: Member?) -> Void) = {_ in}
    
    override func awakeFromNib() {
        table.register(UINib.init(nibName: "MemberViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
    }
    
    @IBAction func pressSelect(_ sender: Any) {
        callBack(memberSlect)
    }
}

extension SearchMember: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listmember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MemberViewCell
        cell?.binMember(listmember[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        memberSlect = listmember[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
