//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Matthew Hanlon on 2/23/24.
//

import SwiftUI

enum CupcakePage {
    case address, checkout
}

struct ContentView: View {
    @State private var order = Order()
    @State private var path = [CupcakePage]()

    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink("Delivery details", value: CupcakePage.address)
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationDestination(for: CupcakePage.self) { page in
                switch page {
                case .address:
                    AddressView(order: order, path: $path)
                case .checkout:
                    CheckoutView(order: order, path: $path)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
