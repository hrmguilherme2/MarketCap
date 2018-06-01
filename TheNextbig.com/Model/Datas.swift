//
//  Datas.swift
//  customTableViewCell
//
//  Created by Guilherme Moreira on 23/05/2018.
//  Copyright © 2018 Guilherme Moreira. All rights reserved.
//

import Foundation

struct coincap : Codable {
    
    let cap24hrChange : Double?
    var long : String?
    let mktcap : Double?
    let perc : Double?
    let price : Double?
    let shapeshift : Bool?
    let short : String?
    let supply : Int?
    let usdVolume : Double?
    let volume : Double?
    let vwapData : Double?
    let vwapDataBTC : Double?
    
    
}

class selection {
    static var exchanges: [coincap] = []
    static var selectedTitle = ""
    static var selectedBarTitle = ""
    static var imageLink = ""
    static var key = ""
    static var mktCap =   ""
    static var VolToday = ""
    static var AvailableSupply = ""
    static var changePerc = ""
    
}

