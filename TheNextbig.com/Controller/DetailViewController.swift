//
//  DetailViewController.swift
//  TheNextbig.com
//
//  Created by Guilherme Moreira on 25/05/2018.
//  Copyright © 2018 Guilherme Moreira. All rights reserved.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController {

    @IBOutlet weak var lblTitleCoin: UILabel!
    @IBOutlet weak var lblVolToday: UILabel!
    @IBOutlet weak var lblAvaiSupply: UILabel!
    
    @IBOutlet weak var lblchangePerc: UILabel!
    @IBOutlet weak var lblmktCap: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleCoin.text = selection.selectedTitle
        lblVolToday.text = selection.VolToday
        lblAvaiSupply.text = selection.AvailableSupply
        lblmktCap.text = selection.mktCap
        self.title = selection.selectedBarTitle
        if (Double(selection.changePerc))! > Double(0) {
            lblchangePerc.textColor = UIColor(red: CGFloat(175.0/255.0), green: CGFloat(224.0/255.0), blue: CGFloat(182.0/255.0), alpha: CGFloat(1.0))
        } else {
            lblchangePerc.textColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(141.0/255.0), blue: CGFloat(141.0/255.0), alpha: CGFloat(1.0))
        }
        print(selection.changePerc)
        lblchangePerc.text = String(format: "%@",selection.changePerc) + "%"
        let url = URL(string: selection.imageLink)!
        let imgCache = ImageResource(downloadURL: url, cacheKey: selection.key)
        icon.kf.setImage(with: imgCache)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
