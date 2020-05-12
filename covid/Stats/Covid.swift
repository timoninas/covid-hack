//
//  Covid.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Timeseries: Codable {
    var Global: GGlobal?
    var Countries: [ССountries]?
}

struct GGlobal: Codable {
    var NewConfirmed: Int = 0
    var TotalConfirmed: Int = 0
    var NewDeaths: Int = 0
    var TotalDeaths: Int = 0
    var NewRecovered: Int = 0
    var TotalRecovered: Int = 0
    
}

struct ССountries: Codable {
    var Country: String = ""
    var CountryCode: String = ""
    var Slug: String = ""
    var TotalConfirmed: Int = 0
    var NewConfirmed: Int = 0
    var NewDeaths: Int = 0
    var TotalDeaths: Int = 0
    var NewRecovered: Int = 0
    var TotalRecovered: Int = 0
    var Date: String = ""
}
