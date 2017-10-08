//
//  PreviewMessageCell.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 9. 28..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

class PreviewMessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBoxImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var previewTitle: UILabel!
    @IBOutlet weak var previewContent: UITextView!
    @IBOutlet weak var previewDate: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

