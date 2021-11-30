//
//  GameTableViewCell.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 19/08/21.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleText: UILabel!
    @IBOutlet weak var gameSubtitleText: UILabel!
    @IBOutlet weak var gameReleaseText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
