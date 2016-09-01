import UIKit
import Cartography

protocol VideoBoxDelegate: class {
  func videoBoxDidTap(videoBox: VideoBox)
}

class VideoBox: UIView {

  lazy var imageView: UIImageView = self.makeImageView()
  lazy var cameraImageView: UIImageView = self.makeCameraImageView()

  weak var delegate: VideoBoxDelegate?

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action

  func viewTapped(gr: UITapGestureRecognizer) {
    delegate?.videoBoxDidTap(self)
  }

  // MARK: - Setup

  func setup() {
    backgroundColor = UIColor.clearColor()
    Utils.addRoundBorder(imageView)

    let gr = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
    addGestureRecognizer(gr)

    [imageView, cameraImageView].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    constrain(imageView, cameraImageView) {
      imageView, cameraImageView in

      imageView.edges == imageView.superview!.edges

      cameraImageView.left == cameraImageView.superview!.left + 5
      cameraImageView.bottom == cameraImageView.superview!.bottom - 5
      cameraImageView.width == 12
      cameraImageView.height == 6
    }
  }

  // MARK: - Controls

  func makeImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.clipsToBounds = true

    return imageView
  }

  func makeCameraImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.image = Bundle.image("gallery_video_cell_camera")

    return imageView
  }
}