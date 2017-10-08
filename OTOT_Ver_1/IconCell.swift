//
//  IconCell.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 10. 7..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    var icon: Icons? {
        didSet {
            guard let icon = icon else { return }
            imgIcon.image = icon.image()
        }
    }
    
    
}
