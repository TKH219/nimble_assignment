//
//  ProfileSideMenuViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileSideMenuViewModel: BaseViewModel {
    func logout() {
        resolver.resolve(UserSessionDataStore.self)!.delete()
    }
}
