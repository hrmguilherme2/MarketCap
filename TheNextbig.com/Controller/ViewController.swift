//
//  ViewController.swift
//  customTableViewCell
//
//  Created by Guilherme Moreira on 23/05/2018.
//  Copyright © 2018 Guilherme Moreira. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
 
    var coins: [String] = []
    var exchanges: [coincap] = []
    var exchanges_results: [coincap] = []
    var results: [coincap] = []
    var rows = 25 //Init with 25 cells
    var isSearching = false
    let currencyFormatter = NumberFormatter()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    func loadDatafromURL() {
        
        let urlString = "http://coincap.io/front"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                self.exchanges  = try JSONDecoder().decode([coincap].self, from: data)
                print("ViewDidload: ", self.exchanges.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let erro {
                print("Error: ", erro)
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        //Miscs
        navigationController?.hidesBarsOnTap = false
        loadDatafromURL()
        //Delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        //Currency Format
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale =  Locale(identifier: "en_US")
        
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
            if  exchanges.count != 0   {
                if indexPath.row < exchanges.count {
                    if isSearching {
                        //searching cell
                        cell.lblMoeda.text = exchanges_results[indexPath .row].long!
                        cell.lblValue.text = String(format: "%@", currencyFormatter.string(from: exchanges_results[indexPath . row].price! as NSNumber)!)
                        if exchanges_results[indexPath .row].perc! > Double(0) {
                            cell.lblPercent.textColor = UIColor(red: CGFloat(175.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(182.0/255.0), alpha: CGFloat(1.0))
                        } else {
                            cell.lblPercent.textColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(141.0/255.0), blue: CGFloat(141.0/255.0), alpha: CGFloat(1.0))
                        }
                        cell.lblPercent.text = String(format: "%.02f%",exchanges_results[indexPath .row].perc!) + "%"
                        cell.lblSubtitle.text = exchanges_results[indexPath .row].short!
                        let urlFormer = "https://coincap.io/images/coins/"
                        var urlString = urlFormer + exchanges_results[indexPath .row].long! + ".png"
                        urlString = urlString.replacingOccurrences(of: " ", with: "%20", options:NSString.CompareOptions.literal, range:nil)
                        let url = URL(string: urlString)!
                        let imgCache = ImageResource(downloadURL: url, cacheKey: exchanges_results[indexPath.row].long!)
                        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                        cell.imgThumb.kf.setImage(with: imgCache)
                    } else {
                        //master cell
                    cell.lblMoeda.text = exchanges[indexPath .row].long!
                    cell.lblValue.text = String(format: "%@", currencyFormatter.string(from: exchanges[indexPath . row].price! as NSNumber)!)
                    if exchanges[indexPath .row].perc! > Double(0) {
                        cell.lblPercent.textColor = UIColor(red: CGFloat(175.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(182.0/255.0), alpha: CGFloat(1.0))
                    } else {
                        cell.lblPercent.textColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(141.0/255.0), blue: CGFloat(141.0/255.0), alpha: CGFloat(1.0))
                    }
                    cell.lblPercent.text = String(format: "%.02f%",exchanges[indexPath .row].perc!) + "%"
                    cell.lblSubtitle.text = exchanges[indexPath .row].short!
                    let urlFormer = "https://coincap.io/images/coins/"
                    var urlString = urlFormer + exchanges[indexPath .row].long! + ".png"
                    urlString = urlString.replacingOccurrences(of: " ", with: "%20", options:NSString.CompareOptions.literal, range:nil)
                    let url = URL(string: urlString)!
                    let imgCache = ImageResource(downloadURL: url, cacheKey: exchanges[indexPath.row].long!)
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                        cell.imgThumb.kf.setImage(with: imgCache)
                        
                    }
                }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            //searching result selection
            selection.selectedTitle = exchanges_results[indexPath .row].long!
            selection.selectedBarTitle = exchanges_results[indexPath .row].short!
            let urlFormer = "https://coincap.io/images/coins/"
            var urlString = urlFormer + exchanges_results[indexPath .row].long! + ".png"
            urlString = urlString.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range:nil)
            selection.imageLink = urlString
            selection.key = exchanges_results[indexPath . row].long!
            selection.mktCap = String(format: "%@",  currencyFormatter.string(from: exchanges_results[indexPath .row].mktcap! as NSNumber)!)
            selection.VolToday = String(format: "%@", currencyFormatter.string(from: exchanges_results[indexPath .row].volume! as NSNumber)!)
            selection.AvailableSupply = String(format: "%@", currencyFormatter.string(from: exchanges_results[indexPath .row].supply! as NSNumber)!)
            selection.changePerc = String(exchanges_results[indexPath .row].cap24hrChange!)
        } else {
            //original array
        selection.selectedTitle = exchanges[indexPath .row].long!
        selection.selectedBarTitle = exchanges[indexPath .row].short!
        let urlFormer = "https://coincap.io/images/coins/"
        var urlString = urlFormer + exchanges[indexPath .row].long! + ".png"
        urlString = urlString.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range:nil)
        selection.imageLink = urlString
        selection.key = exchanges[indexPath . row].long!
        selection.mktCap = String(format: "%@",  currencyFormatter.string(from: exchanges[indexPath .row].mktcap! as NSNumber)!)
        selection.VolToday = String(format: "%@", currencyFormatter.string(from: exchanges[indexPath .row].volume! as NSNumber)!)
        selection.AvailableSupply = String(format: "%@", currencyFormatter.string(from: exchanges[indexPath .row].supply! as NSNumber)!)
        selection.changePerc = String(exchanges[indexPath .row].cap24hrChange!)
            print(selection.changePerc )}
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          self.searchBar.endEditing(true)
        if isSearching == false {
            let  height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            
            if distanceFromBottom < height {
                rows += 25
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    //SearchBar Funcs
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text!)
        if searchBar.text == "" {
            
            self.searchBar.endEditing(true)
            rows = 25
            loadDatafromURL()
            isSearching = false
            exchanges_results.removeAll()
            self.tableView.reloadData()
            
        } else {
             isSearching = true
            filterContentForSearchText(searchText: searchBar.text!)
            rows = exchanges_results.count
            self.tableView.reloadData()
            
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        exchanges_results = exchanges.filter { item in
            return item.long!.lowercased().contains(searchText.lowercased())
        }
    }
    
    
}












