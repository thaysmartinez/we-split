//
//  ContentView.swift
//  WeSplit
//
//  Created by Thays Martinez on 20/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: (Double, Double) {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount ?? 0.0) / 100 * tipSelection
        let grandTotal = (checkAmount ?? 0.0) + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return (amountPerPerson, grandTotal)
    }
    
    let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", value: $checkAmount, format:
                            .currency(code: Locale
                                .current
                                .currency?
                                .identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                    
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                
                Section {
                    Text(totalPerPerson.0, format: currencyFormatter)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalPerPerson.1, format: currencyFormatter)
                } header: {
                    Text("Total amount")
                } footer: {
                    Text("Sum of check amount plus tip value")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
