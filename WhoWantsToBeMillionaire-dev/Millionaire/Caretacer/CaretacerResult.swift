//
//  Caretacer.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import Foundation

class GameCaretacer {
    
   private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game"
    
    func saveGameSessionResult(results: [Result]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print (error)
        }
    }
    
    func loadResult() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
