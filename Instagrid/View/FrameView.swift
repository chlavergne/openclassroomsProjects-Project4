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
            button2.isHidden = true
            button4.isHidden = false
        case .wideBottom:
            button2.isHidden = false
            button4.isHidden = true
        case .fourSquare:
            button2.isHidden = false
            button4.isHidden = false
        }
    }
    @IBOutlet private var button1 : UIButton!
    @IBOutlet private var button2 : UIButton!
    @IBOutlet private var button3 : UIButton!
    @IBOutlet private var button4 : UIButton!
   
    
    
    
}
