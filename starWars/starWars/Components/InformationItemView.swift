//
//  InformationItemView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct InformationItemView: View {
    
    var localizedKey: LocalizedStringKey
    var value: String
    init(name: String, value: String) {
        self.localizedKey = LocalizedStringKey(name)
        self.value = value
    }
    
    var body: some View {
        VStack {
            HStack(alignment: VerticalAlignment.top) {
                Text(self.localizedKey)
                    .font(.system(size: 14))
                Spacer()
                Text(self.value)
                    .bold()
            }
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 1)
        }
    }
}

struct InformationItemView_Previews: PreviewProvider {
    static var previews: some View {
        InformationItemView(name: String.Empty, value: String.Empty)
    }
}
