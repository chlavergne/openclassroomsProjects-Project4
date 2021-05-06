//
//  FrameSelect.swift
//  Instagrid
//
//  Created by Christophe Expleo on 04/05/2021.
//

import UIKit

class StyleSelect : UIView {
    enum Style {
        case wideTop, wideBottom, fourSquare
    }
    var style : Style = .wideTop

    private func setStyle(_ style: Style) {
        switch style {
        case .wideTop:
            break
        case .wideBottom:
            break
        case .fourSquare:
            break
        }
    }
}
