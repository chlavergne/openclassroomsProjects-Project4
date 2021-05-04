//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Expleo on 03/05/2021.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var buttonWideTop: UIButton!
    @IBOutlet weak var buttonWideBottom: UIButton!
    @IBOutlet weak var buttonFourSquare: UIButton!
    
    @IBAction func tapButtonWideTop(_ sender: UIButton) {
        StyleSelect.style = .wideTop
        buttonWideTop.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    @IBAction func tapButtonWideBottom(_ sender: UIButton) {
        StyleSelect.style = .wideBottom
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    @IBAction func tapButtonFourSquare(_ sender: UIButton) {
        StyleSelect.style = .fourSquare
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

