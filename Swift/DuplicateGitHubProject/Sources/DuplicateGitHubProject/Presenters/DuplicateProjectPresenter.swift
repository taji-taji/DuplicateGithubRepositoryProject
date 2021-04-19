//
//  DuplicateProjectPresenter.swift
//  ConsoleKit
//
//  Created by 多鹿豊 on 2021/04/19.
//

import Foundation

protocol DuplicateProjectOutputBoundary {
    func print(owner: String)
}

class DuplicateProjectPresenter: DuplicateProjectOutputBoundary {
    private let view: DuplicateProjectViewInterface
    private let inputBoundary: DuplicateProjectInputBoundary
    
    init(view: DuplicateProjectViewInterface, inputBoundary: DuplicateProjectInputBoundary) {
        self.view = view
        self.inputBoundary = inputBoundary
    }
    
    func print(owner: String) {
        view.print(owner: owner)
    }
}
