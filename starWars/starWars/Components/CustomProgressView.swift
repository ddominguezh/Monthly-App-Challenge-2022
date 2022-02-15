//
//  CustomProgressView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 8/2/22.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
            .padding(25)
            .background(Color.background)
            .cornerRadius(50)
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
