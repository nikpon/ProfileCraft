import UIKit

final class EmojiEmitterLayerAnimator {
    
    // MARK:- Properties
    private let bounds = UIScreen.main.bounds
    let emojiImages: [UIImage?]
    
    // MARK:- Initializer
    init(emojiImages: [UIImage?]) {
        self.emojiImages = emojiImages
    }
    
    // MARK:- Methods
    func createEmitterLayer() -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        
        emitter.emitterPosition = CGPoint(x: bounds.width / 2, y: bounds.height + 40)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
        emitter.emitterCells = makeEmitterCells()
        
        return emitter
    }
    
    private func makeEmitterCells() -> [CAEmitterCell] {
        var cells = [CAEmitterCell()]
        
        for emojiImage in emojiImages {
            let cell = CAEmitterCell()
            
            cell.birthRate = Float.random(in: 0.1...0.6)
            cell.lifetime = 10.0
            cell.velocity = 150
            cell.velocityRange = 50
            cell.spin = 1
            cell.contents = emojiImage?.cgImage
            cells.append(cell)
        }
        
        return cells
    }
    
}
