//
//  WebView.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import SwiftUI
import SafariServices

struct WebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
        
    }
}
