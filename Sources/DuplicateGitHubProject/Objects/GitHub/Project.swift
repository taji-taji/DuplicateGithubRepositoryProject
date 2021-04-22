//
// Created by 多鹿豊 on 2021/04/18.
//

import Foundation

struct Project: Node {
    let id: String
    let name: String
    let number: Int
    let ownerId: String
    let urlString: String
    let columns: [ProjectColumn]
}
