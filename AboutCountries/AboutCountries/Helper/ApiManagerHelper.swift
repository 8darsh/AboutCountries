//
//  ApiManagerHelper.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import Foundation

enum DataError: Error{
    
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(Error?)
}

typealias Handler = (Result<[Countries],DataError>)-> Void
class ApiManagerHelper{
    private var searchQuery: String = ""
    var url:URL?
    private var searchTimer: Timer?
    static let shared = ApiManagerHelper()
    init(){}
    func updateSearchQuery(query: String, completion: @escaping (Result<[Countries], DataError>) -> Void){
        searchQuery = query
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchCountries(completion:completion)
        }
    }
    
    func fetchCountries(completion: @escaping Handler){
        if searchQuery == ""{
            url = URL(string: "\(Constant.API.apiUrl)all")
        }else{
            url = URL(string: "\(Constant.API.apiUrl)name/\(searchQuery)")
        }
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data, error == nil else{
                completion(.failure(.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let country = try JSONDecoder().decode([Countries].self, from: data)
                completion(.success(country))
            }catch{
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}
