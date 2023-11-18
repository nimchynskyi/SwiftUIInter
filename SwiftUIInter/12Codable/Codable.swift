//
//  Codable.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 18/11/2023.
//

import SwiftUI

// Codable = Decodable + Encodable
// Decodable - allows to initialize model from some data, needs its own init
struct CustomerModel: Identifiable, Codable {
    
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // Codable do this all logic automatically
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium //= "is_premium" //
//        /// if name is different
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let data = getJSONData() else { return }
        
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
        
        // with error catch
        
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("Error decodong: \(error)")
//        }
        
        
        // one line with decodable instead of this below
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String:Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool
//        {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "111", name: "Emmily", points: 100, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String:Any] = [
//            "id": "12345",
//            "name": "Joe",
//            "points": 5,
//            "isPremium": true
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
    
}

struct CodableView: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableView()
}
