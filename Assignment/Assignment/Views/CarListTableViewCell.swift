//
//  CarListTableViewCell.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import UIKit

class CarListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carMiles: UILabel!
    @IBOutlet weak var carPlace: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    
    var viewModel: CarListView? {
        didSet {
            carName.text = viewModel?.carName
            carPrice.text = viewModel?.carPrice.description
            carMiles.text = viewModel?.carMiles.description
            carPlace.text = viewModel?.carPlace
            carImageView.image = viewModel?.carImage
            phoneText.text = viewModel?.phone
            
            phoneText.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.phoneDialer(_:)))
            phoneText.addGestureRecognizer(tapGesture)
        
        }
    }
    
    @objc
    func phoneDialer(_ sender:UITapGestureRecognizer) {

        let searchlbl:UILabel = (sender.view as! UILabel) // Type cast it with the class for which you have added gesture
        if let url = NSURL(string: "tel://\(searchlbl.text!)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.canOpenURL(url as URL)
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
    
}
