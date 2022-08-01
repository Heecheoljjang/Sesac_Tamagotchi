//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

struct Tamagotchi: Codable {
    var profileImg = ""
    var name = ""
    var detail = ""
    var number = 0
}
//enum TamagotchiList: CaseIterable {
//    
//    case readyTama, ddaggeumTama, bangsilTama, banjjackTama
//    
//    var profileImage: String {
//        switch self {
//        case .readyTama:
//            return "noImage"
//        case .ddaggeumTama:
//            return "1-6"
//        case .bangsilTama:
//            return "2-6"
//        case .banjjackTama:
//            return "3-6"
//        }
//    }
//    
//    var name: String {
//        switch self {
//        case .readyTama:
//            return "준비중이에요"
//        case .ddaggeumTama:
//            return "따끔따끔 다마고치"
//        case .bangsilTama:
//            return "방실방실 다마고치"
//        case .banjjackTama:
//            return "반짝반짝 다마고치"
//        }
//    }
//    
//    var detail: String {
//        switch self {
//        case .readyTama:
//            return "준비중입니다!!"
//        case .ddaggeumTama:
//            return "저는 따끔따끔 다마고치입니다. 키는 2cm이고 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!"
//        case .bangsilTama:
//            return "저는 방실방실 다마고치입니다. 키는 100km이고 몸무게는 150톤이에요.\n성격은 화끈하고 날라다닙니다! \n열심히 잘 먹고 잘 클 수 있어요.\n반가워요 방실방실~"
//        case .banjjackTama:
//            return "저는 반짝반짝 다마고치입니다. 키는 10m이고 몸무게는 2톤이에요.\n성격은 활발하고 밝습니다!! \n열심히 잘 먹고 잘 클 수 있어요.\n잘 부탁드려요 주인님!"
//        }
//    }
//}


struct TamagotchiList {

    let list = [
        Tamagotchi(profileImg: "1-6", name: "따끔따끔 다마고치", detail: "저는 따끔따끔 다마고치입니다. 키는 2cm이고 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!", number: 1),
        Tamagotchi(profileImg: "2-6", name: "방실방실 다마고치", detail: "저는 방실방실 다마고치입니다. 키는 100km이고 몸무게는 150톤이에요.\n성격은 화끈하고 날라다닙니다! \n열심히 잘 먹고 잘 클 수 있어요.\n반가워요 방실방실~", number: 2),
        Tamagotchi(profileImg: "3-6", name: "반짝반짝 다마고치", detail: "저는 반짝반짝 다마고치입니다. 키는 10m이고 몸무게는 2톤이에요.\n성격은 활발하고 밝습니다!! \n열심히 잘 먹고 잘 클 수 있어요.\n잘 부탁드려요 주인님!", number: 3),
        Tamagotchi(profileImg: "noImage", name: "준비중이에요", detail: "준비중입니다!!", number: 0)
    ]

}
