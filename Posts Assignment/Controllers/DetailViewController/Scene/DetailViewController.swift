//
//  DetailViewController.swift
//  Posts Assignment
//
//  Created by Gourav Kumar on 26/04/24.
//

import UIKit

class DetailViewController: BaseViewController {

    static var storyBoardId: String = ViewControllerId.detailViewController
    static var storyBoardName: String = Storyboard.main
    
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var viewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel?.title
        bodyLabel.text = viewModel?.body
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
