//
//  CategoryView.swift
//  Itinerary
//
//  Created by Alex on 7/28/23.
//

import SwiftUI

// This is a view for the category picker (this could have been done in a simpler manner...)
struct CategoryView: View {
    
    let category: TripCategories
    
    var body: some View {
        Text(category.name)
            .foregroundColor(.orange)
            .tint(.orange)
            .accentColor(.orange)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .Camping)
    }
}
