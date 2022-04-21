import Foundation

struct Elephant: Codable {
    let id: String?
    let index: Int?
    let name, affiliation: String?
    let species: String?
    let sex: String?
    let fictional, dob, dod: String?
    let wikilink: String?
    let image: String?
    let note: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index, name, affiliation, species, sex, fictional, dob, dod, wikilink, image, note
        case v = "__v"
    }
}

typealias Elephants = [Elephant]

