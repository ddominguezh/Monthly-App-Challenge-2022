//
//  Cell.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 7/2/22.
//

import SwiftUI

struct GridCellView: View {
    
    var text: String
    var detailView: AnyView
    
    var body: some View {
        NavigationLink(destination: self.detailView) {
            ZStack(alignment: .bottom) {
                ImageView(name: self.text)
                    .frame(minWidth: CGFloat.zero, maxWidth: .infinity, minHeight: 160, maxHeight: 160)
                Text(self.text)
                    .foregroundColor(.white)
                    .frame(minWidth: CGFloat.zero, maxWidth: .infinity, minHeight: 25, maxHeight: 50)
                    .background(Color.blackAlpha)
            }
            .cornerRadius(16.0)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        GridCellView(text: String.Empty, detailView: AnyView(PeopleRouter.showDetail(people: PeopleModel.NullObject)))
    }
}
