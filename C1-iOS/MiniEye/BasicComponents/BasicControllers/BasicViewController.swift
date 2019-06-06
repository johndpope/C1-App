

import UIKit

class BasicViewController: UIViewController,ViewContainer {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configureSubviews()
    }
    
     func configureSubviews() {
        
    }
}


@objc protocol ViewContainer {
    @objc optional func configureSubviews()
}
