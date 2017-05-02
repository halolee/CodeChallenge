/*
 Challenge Description
 
 Using the provided (paginated) API, find the average cubic weight for all products in the "Air Conditioners" category.
 
 Cubic weight is calculated by multiplying the length, height and width of the parcel. The result is then multiplied by the industry standard cubic weight conversion factor of 250.
 
 API Endpoint
 
 http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com/api/products/1
 Cubic Weight Example
 
 A parcel measuring 40cm long (0.4m) x 20cm high (0.2m) x 30cm wide (0.3m) is equal to 0.024 cubic metres.
 Multiplied by the conversion factor of 250 gives a cubic weight of 6kg.
 
 0.4m x 0.2m x 0.3m = 0.024m3 0.024m3 x 250 = 6kg
 Assume that
 
 All dimensions are provided in centimetres.
 All weights are provided in grams.
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

typealias JSONObject = [String: Any]

// Constant

let baseUrlString = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
let initialPath = "/api/products/1"
let url = URL(string: baseUrlString + initialPath)!
let targetCategory = "Air Conditioners"

// Calculator

struct Calculator {
    static func averageCubicWeight (for list: [Object], with category: String) -> String {
        let filterredList = list.filter { $0.category == category }
        let totalWeight: Float = filterredList.map{ $0.size.cubicMeter * 250.0 }.reduce(0.0 , {$0 + $1})
        let formattedString = String(format: "%.02fkg", locale: Locale.current, arguments: [totalWeight / Float(filterredList.count)])
        return formattedString
    }
}

// Domain Model

struct Objects {
    let list: [Object]
}

extension Objects {
    init(json: JSONObject) {
        guard let jsonArray = json["objects"] as? [JSONObject] else {
            preconditionFailure("Expected valid objects to be parsed")
        }
        self.list = jsonArray.flatMap{ json in Object(json: json) }
    }
}

struct Object {
    let category: String
    let title: String
    let weight: Float
    let size: Size
}

extension Object {
    init(json: JSONObject) {
        guard let category = json["category"] as? String,
            let title = json["title"] as? String,
            let weight = json["weight"] as? Float,
            let sizeJson = json["size"] as? JSONObject
            else {
                preconditionFailure("Expected valid object to be parsed")
        }
        
        self.category = category
        self.title = title
        self.weight = weight
        self.size = Size(json: sizeJson)
    }
}

struct Size {
    let length: Float
    let height: Float
    let width: Float
    
    var cubicMeter: Float {
        return (length / 100.0) * (height / 100.0) * (width / 100.0)
    }
}

extension Size {
    init(json: JSONObject) {
        // All dimensions are provided in centimetres
        guard let height = json["height"] as? Float,
            let length = json["length"] as? Float,
            let width = json["width"] as? Float else {
                preconditionFailure("Expected valid size to be parsed")
        }
        self.height = height
        self.length = length
        self.width = width
    }
}

// Network Request

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data else { return }
    let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
    if let jsonObject = json as? JSONObject {
        let objects = Objects(json: jsonObject)
        let averageWeight = Calculator.averageCubicWeight(for: objects.list, with: targetCategory)
        print(averageWeight)
    }
}
task.resume()

// Simple Test Case

let testSize = Size(length: 40, height: 20, width: 30)
let testCategory = "Test Category"
let testObject = Object(category: testCategory, title: "Test Object", weight: 0.0, size: testSize)
Calculator.averageCubicWeight(for: [testObject], with: testCategory)

