//
//  FrameView.swift
//  Instagrid
//
//  Created by Christophe Expleo on 05/05/2021.
//

import UIKit

class FrameView: UIStackView {
    enum Style {
        case wideTop, wideBottom, fourSquare
    }
    
    var style: Style = .wideTop {
        didSet {
            setStyle(style)
        }
    }
    private func setStyle(_ style: Style) {
        switch style {
        case .wideTop:
            backgroundColor = UIColor(red: 200.0/255.0, green: 236.0/255.0, blue: 160.0/255.0, alpha: 1)
            if button2 == nil {
                print("vide")
            }
        //            button2.isHidden = true
        //            button4.isHidden = false
        case .wideBottom:
            backgroundColor = UIColor(red: 243.0/255.0, green: 135.0/255.0, blue: 148.0/255.0, alpha: 1)
            if button2 == nil {
                print("vide")
            }
        //            button2.isHidden = false
        //            button4.isHidden = true
        case .fourSquare:
            if button2 == nil {
                print("vide")
            }
        //            button2.isHidden = false
        //            button4.isHidden = false
        }
    }
    @IBOutlet private var button1 : UIButton!
    @IBOutlet private var button2 : UIButton!
    @IBOutlet private var button3 : UIButton!
    @IBOutlet private var button4 : UIButton!
    
    
    
    
    
}
