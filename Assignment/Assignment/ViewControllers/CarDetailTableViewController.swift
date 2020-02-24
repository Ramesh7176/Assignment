//
//  CarDetailTableViewController.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import UIKit

class CarDetailTableViewController: UITableViewController {
    
    var carModelObject = listingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "CarListTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SnapshotTableViewCell", bundle: nil), forCellReuseIdentifier: "snapshotcellid")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 1
        }
        else {
            return carModelObject.onePriceArrows?.count ?? 0
        }
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0) {
            return 350
        }
        else {
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return nil
        }
        else {
            return "Snapshot Details"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! CarListTableViewCell
            
            //Use image's path to create NSData
            //let url:NSURL = NSURL(string : item.images?.baseUrl!)
            let url:NSURL = NSURL(string : "https://carfax-img.vast.com/carfax/4550688195707539809/1/344x258")!
            //Now use image to create into NSData format
            let imageData:NSData = NSData.init(contentsOf: url as URL)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            let image = decodedimage
            
            let CarListViewObj = CarListView (carName: (carModelObject.make ?? "") + " " + (carModelObject.model ?? ""),
                             carPrice: carModelObject.listPrice ?? 0,
                             carMiles: carModelObject.mileage ?? 0,
                             carPlace: carModelObject.dealer?.city ?? "",
                             phone: carModelObject.dealer?.phone ?? "",
                             carImage: image ?? UIImage()
                            )
               cell.viewModel = CarListViewObj
               return cell
        }
        else if(indexPath.section == 1) {
            //var viewModel: CarDetailView
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "snapshotcellid", for: indexPath) as! SnapshotTableViewCell
            let tempIconImage = getImage(imageURL:carModelObject.onePriceArrows?[indexPath.row].iconUrl ?? "")
            let tempSnapshotText = carModelObject.onePriceArrows?[indexPath.row].text ?? ""
            cell.viewModel =  CarDetailView(iconImage: tempIconImage, snapshotText: tempSnapshotText)
            return cell
        }
        else {
            //remove it later
            return UITableViewCell()
        }
    }
    
    
    func getImage(imageURL: String) -> UIImage {
        let url:NSURL = NSURL(string : "https://media.carfax.com/img/vhr/ico_noAccident.gif")!
        //Now use image to create into NSData format
        let imageData:NSData = NSData.init(contentsOf: url as URL)!
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        return UIImage(data: dataDecoded) ?? UIImage()
    }
    

}
