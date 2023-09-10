//
//  RickAndMortyService.swift
//  trabalho_ios_01
//
//  Created by BRUNO MOREIRA BATISTA on 08/09/23.
//

import Foundation

enum RickAndMortyServiceError: Error {
    case invalidURL
    case couldNotReturnCharacterList(errorCode: Int)
    case couldNotDecodeObject
    case couldNotGetError
}

class RickAndMortyService {
    
//    func fetchCharacterList(page: Int = 1) async throws {
//
//    }
    
    func fetchCharacterList(
        page: Int = 1,
        completion: @escaping (Result<[RickAndMortyCharacter], RickAndMortyServiceError>) -> Void
    ) {
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, error == nil else {
                completion(.failure(.couldNotReturnCharacterList(errorCode: 202)))
                return
            }

//            print(urlResponse)
//            print(data)
//            print(error)
            
            do {
                let response = try JSONDecoder().decode(RickAndMortyResponse.self, from: data)
                completion(.success(response.results))
            } catch {
//                if let error = error as? DecodingError {
//
//                }
                
                completion(.failure(.couldNotReturnCharacterList(errorCode: 400)))
            }
        }
        task.resume()
    }
    

    func fetchCharacterList(page: Int = 1) async throws ->
        [RickAndMortyCharacter] {
  
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
            
            guard let url = URL(string: urlString) else {
                throw RickAndMortyServiceError.invalidURL
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(RickAndMortyResponse.self, from: data)
                return response.results
                //} catch let urlError as URLError {
            } catch {
                throw RickAndMortyServiceError.couldNotReturnCharacterList(errorCode: 400)
            }
    }
}
