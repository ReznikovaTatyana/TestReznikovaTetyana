//
//  PreloaderViewController.swift
//  TestReznikovaTetyana
//
//  Created by mac on 10.09.2024.
//

import UIKit

class PreloaderViewController: UIViewController {
    
    lazy var preloaderView: PreloaderView = PreloaderView(frame: .zero)
    var preloaderModel = PreloaderModel()
    let nasa = NetworkMager(configuration: .default)
    weak var homeViewController: HomeViewController?
    
    override func loadView() {
        view = preloaderView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        preloaderModel.nextController(vc: self)
        

    }
    
}
