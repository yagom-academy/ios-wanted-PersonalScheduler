//
//  InputSchedulVM.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/11.
//

import Foundation

class InputSchedulVM: ViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
