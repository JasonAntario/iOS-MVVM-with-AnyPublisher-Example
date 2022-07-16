//
//  TempViewModel.swift
//  MVVM_publisher_test
//
//  Created by Dmitry Sankovsky on 9.07.22.
//

import Foundation
import Combine

class TempViewModel: ObservableObject{
    
    @Published var city: String = "Minsk"
    @Published var currentWeather = WeatherDetails.placeholder
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city: String) -> AnyPublisher<WeatherDetails, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
            }
            .assign(to: \.currentWeather, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
}
