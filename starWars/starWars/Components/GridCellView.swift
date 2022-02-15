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
            ZStack {
                Rectangle()
                    .background(Color.blackAlpha)
                    .foregroundColor(.clear)
                VStack{
                    ImageView(name: self.text)
                        .frame(width: 100, height: 100)
                    Spacer()
                    Text(self.text)
                        .foregroundColor(.white)
                }.padding(16)
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
