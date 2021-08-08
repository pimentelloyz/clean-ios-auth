import Foundation
import UIKit
import Infra


func makeGoogleAuthAdapterAdapter(controller: UIViewController) -> GoogleAuthAdapter {
    return GoogleAuthAdapter(controller: controller)
}
