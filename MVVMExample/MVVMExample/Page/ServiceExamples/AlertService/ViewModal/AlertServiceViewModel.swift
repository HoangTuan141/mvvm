//
//  AlertServiceViewModel.swift
//  MVVMExample
//
//  Created by pham.minh.tien on 7/15/20.
//  Copyright © 2020 Sun*. All rights reserved.
//

import UIKit
import MVVM
import Action
import RxSwift
import RxCocoa

class AlertServiceViewModel: BaseViewModel {
    var alertService: AlertService?
    let rxSubmitButtonEnabled = BehaviorRelay(value: true)
    let rxConfirmAction = BehaviorRelay(value: true)
    
    lazy var submitAction: Action<Void, Void> = {
        return Action(enabledIf: self.rxSubmitButtonEnabled.asObservable()) {
            self.alertService?.presentPMConfirmAlert(title: "Submit Button Clicked!",
                                                               message: "You have just clicked on submit button.? Do you want submit?",
                                                               yesText: "OK",
                                                               noText: "Cancel").subscribe(onSuccess: { (confirm) in
                                                                self.rxConfirmAction.accept(confirm)
                                                               }, onError: { (error) in
                                                                
                                                               })
            
            return .just(())
        }
    }()
    
    override func react() {
        super.react()
        alertService = DependencyManager.shared.getService()
    }

}
