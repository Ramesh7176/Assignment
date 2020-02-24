//
//  SnapshotTableViewCell.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import UIKit

class SnapshotTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var snapshotText: UILabel!
    
    var viewModel: CarDetailView? {
           didSet {
               snapshotText.text = viewModel?.snapshotText
               iconImage.image = viewModel?.iconImage
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
