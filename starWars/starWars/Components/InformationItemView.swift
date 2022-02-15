//
//  InformationItemView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct InformationItemView: View {
    
    var name: String
    var value: String
    
    var body: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("\(self.name):")
                .font(.system(size: 14))
            Spacer()
            Text(self.value)
                .bold()
        }
    }
}

struct InformationItemView_Previews: PreviewProvider {
    static var previews: some View {
        InformationItemView(name: String.Empty, value: String.Empty)
    }
}
