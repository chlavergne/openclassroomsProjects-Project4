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
    @IBOutlet weak var frameView: FrameView!
    
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    
    @IBAction func tapButtonWideTop(_ sender: UIButton) {
        //        FrameView().style = .wideTop
        button2.isHidden = true
        button4.isHidden = false
        buttonWideTop.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    @IBAction func tapButtonWideBottom(_ sender: UIButton) {
        //        FrameView().style = .wideBottom
        button2.isHidden = false
        button4.isHidden = true
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    @IBAction func tapButtonFourSquare(_ sender: UIButton) {
        //        FrameView().style = .fourSquare
        button2.isHidden = false
        button4.isHidden = false
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

