
import Foundation
import UIKit

class SetImageToElement: Operation {
    private let button: UIButton
    
    init(button: UIButton) {
        self.button = button
    }
    
    override func main() {
        
        guard
            let getCacheImage = dependencies[0] as? GetCacheImage,
            let image = getCacheImage.outputImage else { return }
        
        button.imageView?.image = image
        
//        switch field {
//        case "logoSourseView":
//            if let newIndexPath = tableView.indexPath(for: cell), newIndexPath == indexPath {
//                cell.logoSourseView.image = image
//            } else if tableView.indexPath(for: cell) == nil {
//                cell.logoSourseView.image = image
//            }
//        case "postPhotoImageView":
//            if let newIndexPath = tableView.indexPath(for: cell), newIndexPath == indexPath {
//                cell.postPhotoImageView.image = image
//            } else if tableView.indexPath(for: cell) == nil {
//                cell.postPhotoImageView.image = image
//            }
//        default:
//            return
//        }
        
    }
}
