import UIKit

final class ViewController: UIViewController {
    private let headerHeight: CGFloat = 270
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(headerView)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        let size = UIScreen.main.bounds.size
        scrollView.contentSize = .init(width: size.width, height: 3 * size.height)
        return scrollView
    }()
    
    lazy var darkImageView = createImageView("dark")
    lazy var lightImageView = createImageView("light")
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(lightImageView)
        view.addSubview(darkImageView)
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        headerView.frame = view.bounds
        headerView.frame.size.height = headerHeight
        darkImageView.frame = headerView.bounds
        lightImageView.frame = headerView.bounds
    }
    
    func createImageView(_ imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        headerView.frame.origin.y = -y
        headerView.frame.size.height = headerHeight + y
        darkImageView.frame = headerView.bounds
        lightImageView.frame = headerView.bounds
        darkImageView.alpha = y < 0 ? 1.0 : (1 - y / 150.0)
        scrollView.verticalScrollIndicatorInsets.top = headerHeight + (y > 0 ? y : 0) - view.safeAreaInsets.top
    }
}
