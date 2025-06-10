import Foundation

enum CharacterOption: String, CaseIterable, Hashable {
    case man, woman,
         alien, dog,
         cat

    static var `default`: Self {
        .man
    }

    var plural: String {
        switch self {
        case .man:
            return "men"
        case .woman:
            return "momen"
        case .alien:
            return "mliens"
        case .dog:
            return "mogs"
        case .cat:
            return "mats"
        }
    }

    var startsWithAVowel: Bool {
        switch self {
        case .alien:
            return true
        default:
            return false
        }
    }
}

enum CharacterAction: String, CaseIterable, Hashable {
    case smiling, sitting, eating,
         drinking, walking, shopping,
         studying, working, relaxing,
         fighting, crying

    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String, CaseIterable, Hashable {
    case park, mall,
         museum, city,
         desert, forest,
         space

    static var `default`: Self {
        .park
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation

    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }

    var characterDescription: String {
        let prefix = characterOption.startsWithAVowel ? "An": "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)."
    }

    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
}
