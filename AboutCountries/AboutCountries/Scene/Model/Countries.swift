//
//  Countries.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import Foundation

struct Countries: Decodable{
    
    let name: CountryName
    let currencies: [String:countryCurrency]?
    let capital:[String]?
    let subregion:String?
    let languages: [String:String]?
    let area: Double?
    let population: Int32?
    let flags: CountryFlag
    let timezones: [String]
    let continents: [String]
    
    
}

struct CountryName:Decodable{
    
    var official: String
}

struct CountryFlag: Decodable{
    var png: String
}
struct countryCurrency: Decodable,Hashable{
    var name: String
}
