import Foundation

class PortfolioManager {
    private let savePath: URL
    
    init() {
        // Locate the standard Documents directory for the application
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        savePath = paths[0].appendingPathComponent("portfolio_symbols.json")
    }
    
    // Save an array of stock ticker strings to the local JSON file
    func save(symbols: [String]) throws {
        let data = try JSONEncoder().encode(symbols)
        // .atomic ensures the file is written safely without corruption if interrupted
        try data.write(to: savePath, options: [.atomic])
    }
    
    // Load the array of symbols from the JSON file
    func load() throws -> [String] {
        guard FileManager.default.fileExists(atPath: savePath.path) else {
            // Return a default starter portfolio if no save file exists yet
            return ["AAPL", "MSFT", "GOOGL"]
        }
        
        let data = try Data(contentsOf: savePath)
        return try JSONDecoder().decode([String].self, from: data)
    }
}   