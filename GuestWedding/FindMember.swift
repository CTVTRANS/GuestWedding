//
//  FindMember.swift
//  GuestWedding
//
//  Created by le kien on 12/14/17.
//  Copyright © 2017 Kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class FindMember: LKNetwork {
    
    var nameSearch: String!
    
    init(nameSearch: String) {
        self.nameSearch = nameSearch
    }
    
    override func path() -> String {
        return seachMemberURL
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        let escapedString: String = nameSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return ["s": escapedString]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}
