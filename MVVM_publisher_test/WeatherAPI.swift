//
//  WeatherAPI.swift
//  MVVM_publisher_test
//
//  Created by Dmitry Sankovsky on 9.07.22.
//

import Foundation
import Combine
import UIKit

class WeatherAPI {
    static let shared = WeatherAPI()
    private let celsiusSign = "°C"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "print_your_api_key_here"
    
    private func absoluteUrl(city: String) -> URL?{
        let queryURL = URL(string: baseUrl)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherDetails, Never>{
        guard let url = absoluteUrl(city: city) else {
            return Just(WeatherDetails.placeholder).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherDetails.self, decoder: JSONDecoder())
            .catch { error in Just(WeatherDetails.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
