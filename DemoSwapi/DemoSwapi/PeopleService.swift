//
//  PeopleService.swift
//  DemoSwapi
//
//  Created by WA on 8/13/19.
//  Copyright © 2019 WA. All rights reserved.
//

import Foundation

struct Hero: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

struct PeopleService {
    let api = "https://swapi.co/api/"
    let endpoint = "people/1"
    let session = URLSession(configuration: .default)

    func saveHero(hero: Hero) {
        guard let url = URL(string: api + endpoint) else { return }
        guard let data = try? JSONEncoder().encode(hero) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        session.dataTask(with: request) { data, response, error in
            // code
        }
    }

    func getFirstHero(complitionHandler: @escaping ((Hero) -> Void)) {
        guard let url = URL(string: api + endpoint) else { return }
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let httpRespose = response as? HTTPURLResponse else {
                print("response cast failed")
                return
            }
            guard httpRespose.statusCode == 200 else {
                print("Unexpected status code")
                return
            }
            guard let data = data else {
                print("No data present")
                return
            }
            do {
                let parsedData = try JSONDecoder().decode(Hero.self, from: data)
                DispatchQueue.main.async {
                    complitionHandler(parsedData)
                }
            } catch {
                print("Decoding failed")
            }
        }
        .resume()
    }
}
