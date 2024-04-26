//
//  PostTableViewCell.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: PostCellViewModelProtocol?) {
        idLabel.text = viewModel?.id
        labelTitle.text = viewModel?.title
    }
    
}
