import UIKit
import Foundation

var baseURL = URLComponents(string:"https://itunes.apple.com/search")!
baseURL.queryItems = [
    "term" : "radioactive",
    "media" : "music"
].map({URLQueryItem(name: $0.key, value: $0.value)})

Task {
    let (data, response) = try await URLSession.shared.data(from: baseURL.url!)
    
    if let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200,
       let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}

