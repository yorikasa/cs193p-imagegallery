//
//  EditableTableViewCell.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/25.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

class EditableTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resignationHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EditableTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Lecture 13: https://youtu.be/ckCjIJbxYLY
        resignationHandler?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
