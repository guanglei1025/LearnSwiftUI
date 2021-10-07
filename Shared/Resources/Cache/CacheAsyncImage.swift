//
//  CacheAsyncImage.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 06/10/2021.
//

import SwiftUI

/// Similar implementation to https://developer.apple.com/documentation/swiftui/asyncimage/
/// `Content` as a generic type that conform to `View` protocol
struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        @ViewBuilder content: @escaping (AsyncImagePhase)-> Content
    ) {
        self.url = url
        self.content = content
    }

    var body: some View {
        if let cachedImage = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")

            // Return cached image
            content(.success(cachedImage))
        } else {
            let _ = print("request \(url.absoluteString)")

            // Return the regular AsyncImage view
            AsyncImage(url: url) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

extension CacheAsyncImage {
    init<I, P>(url: URL, content: @escaping (Image) -> I, placeholder: @escaping () -> P) where
        Content == Group
        <_ConditionalContent
            <_ConditionalContent<I, P>, Never>>,
        I : View,
        P : View {
        self.init(url: url) { phase in
            Group {
                switch phase {
                case .success(let image):
                    content(image)
                case .empty, .failure:
                    placeholder()
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

extension CacheAsyncImage {
    init<I>(url: URL, content: @escaping (Image) -> I) where
        Content == Group
        <_ConditionalContent
            <_ConditionalContent
                <ProgressView<EmptyView, EmptyView>,I>,_ConditionalContent<Text, Never>>>,
        I : View {
        self.init(url: url) { phase in
            Group {
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    content(image)
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

fileprivate class ImageCache {
    static private var cache = [URL: Image]()

    static subscript(_ url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
