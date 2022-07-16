//
//  ContentView.swift
//  MVVM_publisher_test
//
//  Created by Dmitry Sankovsky on 9.07.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = TempViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Weather App")
                .font(.largeTitle)
            TextField("City", text: self.$viewModel.city)
                .textInputAutocapitalization(.words)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .tint(.blue)
            
            Text(
                viewModel.currentWeather.main?.temp != nil ?
                "температура: \(Int((viewModel.currentWeather.main?.temp!)!)) °C" : "")
            Spacer()
        }
        .font(.title)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
