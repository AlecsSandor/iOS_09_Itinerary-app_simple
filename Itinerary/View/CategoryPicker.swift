//
//  CategoryPicker.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI

struct CategoryPicker: View {
    
    @Binding var selection: TripCategories
    
    var body: some View {
        Picker("Category", selection: $selection) {
            ForEach(TripCategories.allCases) { caterogy in
                CategoryView(category: caterogy)
                    .tag(caterogy)
            }
        }
        
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(selection: .constant(.Camping))
    }
}
