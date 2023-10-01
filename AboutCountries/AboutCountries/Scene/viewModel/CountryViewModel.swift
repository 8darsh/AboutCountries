//
//  CountryViewModel.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import Foundation

final class CountryViewModel{
    
    var country:[Countries] = []
    
    var eventHandler:((_ event: Event)->Void)?
    
    func fetchData(){
        
        self.eventHandler?(.loading)
        ApiManagerHelper.shared.fetchCountries{
            response in
            self.eventHandler?(.stopLoading)
            
            switch response{
                
            case .success(let countries):
                self.country = countries
                self.eventHandler?(.loaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}
extension CountryViewModel{
    
    enum Event{
        
        case loading
        case stopLoading
        case loaded
        case error(Error?)
    }
}
