//
//  CountryViewController.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import UIKit

class CountryViewController: UIViewController {
    
    private var viewModel = CountryViewModel()
   
    let search = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var countryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBarSetup()
        configuration()
       
    }
    
    
}

extension CountryViewController{
    
    func configuration(){
        
        initViewModel()
        observeEvent()
        
    }
    
    func initViewModel(){
        viewModel.fetchData()
    }
    
    func observeEvent(){
        
        viewModel.eventHandler = {
            [weak self] event in
            guard let self else {return}
            
            switch event{
                
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stop Loading")
            case .loaded:
                print("Data Loaded")
//                print(self.viewModel.country)
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension CountryViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "cell") as! CountryTableViewCell
        let country = viewModel.country[indexPath.row]
        cell.countries = country
        cell.countryName.text = country.name.official
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        viewModel.fetchData()
        let countries = viewModel.country[indexPath.row]
        
        vc.country = countries
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
}

extension CountryViewController: UISearchControllerDelegate, UISearchBarDelegate{

    
    
   
    
    private func searchBarSetup(){
        
        
        search.searchBar.delegate = self
        navigationItem.searchController = search
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Call the ApiManagerHelper to update the search query
        ApiManagerHelper.shared.updateSearchQuery(query: searchText) { [weak self] result in
            switch result {
                case .success(let countries):
                    // Update the data source and reload the table view
                self?.viewModel.country = countries
                    DispatchQueue.main.async {
                        self?.countryTableView.reloadData()
                    }
                case .failure(let error):
                    // Handle the error, e.g., show an error message to the user
                    print("API Error: \(error)")
                }
            }
        }
    
}
        
       


