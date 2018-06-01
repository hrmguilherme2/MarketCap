//
//  CustomTableViewCell.swift
//  customTableViewCell
//
//  Created by Guilherme Moreira on 23/05/2018.
//  Copyright © 2018 Guilherme Moreira. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMoeda: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    

}
