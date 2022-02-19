//
//  String+Height.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 18/2/22.
//

import SwiftUI

extension String {
    
    func heightFrom() -> CGFloat {
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)
        let textFirstLine: UILabel = .init()
        textFirstLine.text = "A"
        textFirstLine.font = font
        return CGFloat(self.split(whereSeparator: \.isNewline).count+2) * 28.0
    }

}
