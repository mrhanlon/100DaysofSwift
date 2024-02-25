//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Matthew Hanlon on 2/23/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @Binding var path: [CupcakePage]

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out", value: CupcakePage.checkout)
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NavigationStack {
//        AddressView(order: Order(), path: [CupcakePage.address])
//    }
//}
