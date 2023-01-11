//
//  AppAppearance.swift
//  PersonalScheduler
//
//  Created by Ari on 2023/01/11.
//

import UIKit

final class AppAppearance {
    static func setUpAppearance() {
        UIBarButtonItem.appearance().tintColor = .label
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.label]
    }
}

