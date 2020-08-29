import Foundation

class TimerService {
    
    var timer: Timer?
    
    func setTimer(block: @escaping(Timer) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: block)
        
    }
    
    func invalidateTimer() {
        timer?.invalidate()
    }
    
}
