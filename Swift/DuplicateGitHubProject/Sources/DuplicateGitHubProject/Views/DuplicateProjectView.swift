//
//  DuplicateProjectView.swift
//  DuplicateGitHubProject
//
//  Created by 多鹿豊 on 2021/04/19.
//

import ConsoleKit
import Foundation

protocol DuplicateProjectViewInterface: AnyObject {
    func print(owner: String)
}

extension Terminal: DuplicateProjectViewInterface {
    func print(owner: String) {
        print(owner)
    }
}
