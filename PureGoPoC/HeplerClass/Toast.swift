import Foundation
import MBProgressHUD

class Toast {
    
    static let shared = Toast()
    func show(message: String) {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.minShowTime = 1.0
            hud.animationType = .fade
            hud.mode = .text
            hud.label.numberOfLines = 0
            hud.label.text = message
            hud.margin = 10.0
            hud.offset.y = (UIScreen.main.bounds.height / 2) - 60
            hud.removeFromSuperViewOnHide = true
            hud.isUserInteractionEnabled = false
            hud.bezelView.style = .solidColor
            hud.bezelView.color = UIColor.black
            hud.label.textColor = UIColor.white
            hud.label.font.withSize(20)
            hud.hide(animated: true, afterDelay: 3.0)
        }
    }
}
