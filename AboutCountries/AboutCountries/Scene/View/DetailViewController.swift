//
//  DetailViewController.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var capital: UILabel!
    
    @IBOutlet var continent: UILabel!
    
    @IBOutlet var language: UILabel!
    
    @IBOutlet var currency: UILabel!
    
    @IBOutlet var subregion: UILabel!
    
    @IBOutlet var area: UILabel!
    
    @IBOutlet var population: UILabel!
    
    var country: Countries!{
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetails()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendData))
    }
    
    func setDetails(){
        self.imageView?.setImage(with: country?.flags.png ?? "haha")
        self.name?.text = country?.name.official
        self.capital?.text = "Capital: \((country?.capital?.first)!)"
        self.continent?.text = "\((country?.continents.first)!)"
        self.language?.text = "Language: \((country?.languages?.first?.value)!)"
        self.currency.text = "Currency: \((country?.currencies?.keys.first)!)"
        self.subregion?.text = "Subregion: \((country?.subregion)!)"
        self.area?.text = "Area: \((country?.area?.description)!)"
        self.population?.text = "Population:  \((country?.population?.description)!)"
    }
    
    @objc func sendData(){
        let ac = UIActivityViewController(activityItems: [country.area,country.capital,country.continents,country.currencies,country.flags.png,country.name,country.languages?.keys,country.population], applicationActivities: nil)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }




}
