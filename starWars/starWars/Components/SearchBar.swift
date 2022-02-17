//
//  SearchBar.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 6/2/22.
//

import Foundation
import SwiftUI

protocol SearchBarDelegate {
    func onChange(text: String)
}

struct SearchBar: View {
    
    @State private var text: String = String.Empty
    @State private var isEditing = false
    var delegate: SearchBarDelegate
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.black)
            ZStack(alignment: Alignment.leading) {
                if self.text.isEmpty {
                    Text(LocalizedStringKey("search"))
                        .foregroundColor(Color.black)
                }
                TextField(
                    "",
                    text: $text)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .onChange(of: text) { newValue in
                        delegate.onChange(text: newValue)
                    }
                    .foregroundColor(Color.black)
                    .accentColor(Color.black)
                
            }
            if self.isEditing {
                Button(
                    action: {
                        self.text = String.Empty
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.black)
                    }
                )
            }
        }
        .padding(10)
        .background(Color.background)
        .cornerRadius(20)
    }
}
