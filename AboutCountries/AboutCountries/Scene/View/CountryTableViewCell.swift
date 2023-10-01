//
//  CountryTableViewCell.swift
//  AboutCountries
//
//  Created by Adarsh Singh on 14/09/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var countryName: UILabel!
    
    var countries: Countries?{
        
        didSet{
            assignCountryData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func assignCountryData(){
        
        imgView.setImage(with: countries?.flags.png ?? "hehe")
        
    }
    
}
