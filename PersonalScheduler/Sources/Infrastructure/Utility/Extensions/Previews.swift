//
//  Previews.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.
        
#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: String = "iPhone 14 Pro") -> some View {
        Preview(viewController: self)
            .previewDevice(PreviewDevice(rawValue: deviceType))
    }
}
#endif
