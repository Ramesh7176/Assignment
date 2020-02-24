//
//  ViewController.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var carTableView: UITableView!
    
    var carListArray = [listingModel]()
    var carContentArr = [CarListView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeCarlistService()
        populatCarListModel()
        
        carTableView.register(UINib(nibName: "CarListTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        carTableView.delegate = self
        carTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carContentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! CarListTableViewCell
        cell.viewModel = carContentArr[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "cardetailvc") as! CarDetailTableViewController
        vc.carModelObject = carListArray[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    func stringToImage (imageURLString: String?) -> UIImage? {
        do {
            let url = URL(string: imageURLString!)
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)
        }
        catch{
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func populatCarListModel() {
    
        for item in carListArray {

            // Use image's path to create NSData
            // let url:NSURL = NSURL(string : item.images?.baseUrl!)
            // TODO: having issues in getting the UIImage. Need to look into this.
            let url:NSURL = NSURL(string : "https://carfax-img.vast.com/carfax/4550688195707539809/1/344x258")!
            //Now use image to create into NSData format
            let imageData:NSData = NSData.init(contentsOf: url as URL)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            let image = decodedimage
            
            carContentArr.append(CarListView(carName: (item.make ?? "") + " " + (item.model ?? ""),
                                             carPrice: item.listPrice ?? 0,
                                             carMiles: item.mileage ?? 0,
                                             carPlace: item.dealer?.city ?? "",
                                             phone: item.dealer?.phone ?? "",
                                             carImage: image ?? UIImage()
                                            ))
        }
    }
    
    func makeCarlistService() {
        // TODO: having issues in getting the UIImage. Need to look into this.
        let urlString = "https://carfax-for-consumers.firebaseio.com/assignment.json"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                CGLogging.logMetrics(message: "service call completed", metricsType: metricsType.Information)
            }
            else {
                CGLogging.logMetrics(message: "service call failed", metricsType: metricsType.Error)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonCarList = try? decoder.decode(CarListViewModel.self, from: json) {
            carListArray = jsonCarList.listings ?? []
        }
    }
    
}

