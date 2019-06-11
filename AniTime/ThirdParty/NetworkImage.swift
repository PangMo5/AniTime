import SwiftUI
import Nuke
import UIKit

struct NetworkImage: SwiftUI.View {
    
    // swiftlint:disable:next redundant_optional_initialization
    @State private var image: UIImage? = nil
    
    let imageURL: URL?
    let placeholderImage: UIImage
    let animation: Animation = .basic()
    
    var body: some SwiftUI.View {
        Image(uiImage: image ?? placeholderImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear(perform: loadImage)
            .transition(.opacity)
            .id(image ?? placeholderImage)
    }
    
    private func loadImage() {
        guard let imageURL = imageURL, image == nil else { return }
        
        let request = ImageRequest(url: imageURL)
        if let image = ImageCache.shared[request] {
            self.image = image
        } else {
            ImagePipeline.shared.loadImage(with: imageURL) { (response, error) in
                withAnimation(self.animation) {
                    self.image = response?.image
                }
            }
        }
    }
}

#if DEBUG
// swiftlint:disable:next type_name
struct NetworkImage_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        NetworkImage(imageURL: URL(string: "https://www.apple.com/favicon.ico")!,
                     placeholderImage: UIImage(systemName: "bookmark")!)
    }
}
#endif
