//
//  RemoteImage.swift
//  
//
//  Created by Илья Шаповалов on 28.12.2023.
//

import SwiftUI

public struct RemoteImage<I: View, P: View, E: View>: View {
    private let url: URL
    private let configure: (Image) -> I
    private let placeholder: () -> P
    private let errorHandler: (Error) -> E
    private let cache = ImageCache.shared
    
    @State var state: ImageState = .loading
    
    public var body: some View {
        switch state {
        case .loading:
            placeholder()
                .task(priority: .userInitiated, performRequest)
            
        case .success(let image):
            configure(Image(uiImage: image))
            
        case .error(let error):
            errorHandler(error)
        }
    }
    
    //MARK: - init*_:)
    public init(
        url: URL,
        configure: @escaping (Image) -> I = { $0 },
        placeholder: @escaping () -> P = ProgressView.init,
        errorHandler: @escaping (Error) -> E = { _ in EmptyView() }
    ) {
        self.url = url
        self.configure = configure
        self.placeholder = placeholder
        self.errorHandler = errorHandler
    }
    
    //MARK: - Private methods
    @Sendable
    func performRequest() async {
        switch cache.library[url] {
        case .some(let image):
            self.state = .success(image)
            
        case .none:
            self.state = .loading
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    throw URLError(.badURL)
                }
                cache.library.updateValue(image, forKey: url)
                self.state = .success(image)
            } catch {
                self.state = .error(error)
            }
        }
    }
}
 
extension RemoteImage {
    enum ImageState {
        case loading
        case success(UIImage)
        case error(Error)
        
        init(_ result: Result<UIImage, Error>) {
            switch result {
            case .success(let success): self = .success(success)
            case .failure(let failure): self = .error(failure)
            }
        }
    }
}

#Preview {
    RemoteImage(
        url: URL(string: "https://somoskudasai.com/wp-content/uploads/2023/12/portada_sousou-no-frieren-33.jpg")!,
        configure: { $0.resizable().scaledToFit() }
    )
}
