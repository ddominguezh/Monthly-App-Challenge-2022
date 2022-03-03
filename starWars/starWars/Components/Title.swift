//
//  Title.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct Title: View {
    var value: String
    init(_ value: String) {
        self.value = value
    }
    var body: some View {
        Text(LocalizedStringKey(self.value))
            .foregroundColor(.white)
            .bold()
            .font(.system(size: 30))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(String.Empty)
    }
}
