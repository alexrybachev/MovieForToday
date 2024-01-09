//
//  WebPlayerView.swift
//
//
//  Created by Шаповалов Илья on 09.01.2024.
//

import SwiftUI
import WebKit

public struct WebPlayerView: UIViewRepresentable {
    private let link: String
    
    /// Инициализатор для подноценной ссылки на ресурс, например ссылка на трейлер на youtube.
    public init(youtybeLink: String) {
        self.link = youtybeLink
    }
    
    /// Инициализатор для просмотра фильма на ресурсе www.kinopoisk.vip.
    /// Нужно передать id фильма в качестве аргумента.
    public init(movieId: String) {
        self.link = "https://www.kinopoisk.vip/film/".appending(movieId)
    }
    
    public func makeUIView(context: Context) ->  WKWebView {
        let preferences = WKPreferences()
        let configuration = WKWebViewConfiguration()
        
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences = preferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: link) else {
            assertionFailure("Invalid URL link")
            return
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.allowsBackForwardNavigationGestures = true
        uiView.allowsLinkPreview = true
        
        DispatchQueue.main.async {
            uiView.load(URLRequest(url: demoURL))
        }
    }
}

// https://www.kinopoisk.vip/film/48e8d0acb0f62d8585101798eaeceec5/
// https://www.kinopoisk.ru/film/48e8d0acb0f62d8585101798eaeceec5
#Preview {
    VStack {
        WebPlayerView(youtybeLink: "https://www.youtube.com/embed/ZsJz2TJAPjw")
            .padding()
        WebPlayerView(movieId: "48e8d0acb0f62d8585101798eaeceec5")
            .padding()
    }
}
