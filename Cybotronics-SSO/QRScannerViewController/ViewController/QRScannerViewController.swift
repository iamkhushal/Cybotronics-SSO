import UIKit
import AVKit

class QRScannerViewController: UIViewController {
    //MARK: Constants
    static let qrAreaOfInterestViewBorderWidth: CGFloat =  2.0
    static let qrAreaOfInterestViewCornerRadius: CGFloat =  10.0


    //MARK: - UIProperties

    private lazy var cameraPreviewContainerView: UIView = {
        let cameraPreviewContainerView = UIView(frame: .zero)
        return cameraPreviewContainerView
    }()

    private lazy var qrAreaOfInterestView: UIView = {
        let qrAreaOfInterestView = UIView(frame: .zero)
        qrAreaOfInterestView.backgroundColor = .clear
        return qrAreaOfInterestView
    }()

    private lazy var bottomDescription: UILabel = {
        let bottomDescription = UILabel(frame: .zero)
        bottomDescription.text = "Please scan the QR Code"
        bottomDescription.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return bottomDescription
    }()

    // MARK: - Private members
    private var permission: CameraPermission!
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView:UIView?

    //MARK: - Lifecycle



    override func viewDidLoad() {
        super.viewDidLoad()
        permission = CameraPermission(viewController: self)
        setupUI()

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        permission.requestCamera { [weak self] (status) in
            DispatchQueue.main.async {
                if status { self?.setupCameraPreview() }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(false, animated: true)

    }

    // MARK: - Private methods
    private func setupUI() {
        let screenWidth = UIScreen.screenWidth
        self.view.backgroundColor = .white

        self.view.addSubview(cameraPreviewContainerView)
        cameraPreviewContainerView.addConstraintsToFillView(view)

        self.view.addSubview(qrAreaOfInterestView)
        qrAreaOfInterestView.center(inView: view)
        qrAreaOfInterestView.setDimensions(width: screenWidth * 0.69 ,height: screenWidth * 0.69)

        qrAreaOfInterestView.layer.cornerRadius = Self.qrAreaOfInterestViewCornerRadius
        qrAreaOfInterestView.layer.borderWidth = Self.qrAreaOfInterestViewBorderWidth
        qrAreaOfInterestView.layer.borderColor = UIColor.white.cgColor

        self.view.addSubview(bottomDescription)
        bottomDescription.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, insets: UIEdgeInsets(top: .zero, left: 20, bottom: 40, right: 20))
    }

    private func setupCameraPreview() {
        // Get the back-facing camera for capturing videos

        guard videoPreviewLayer == nil else { return }

        let deviceDiscoverySession = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)

        guard let captureDevice = deviceDiscoverySession else { return }

        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Set the input device on the capture session.
            captureSession.addInput(input)

        } catch {
            return
        }

        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds

        guard let previewLayer = videoPreviewLayer else { return }

        cameraPreviewContainerView.layer.addSublayer(previewLayer)

        // Start video capture.
        captureSession.startRunning()
    }



        private func handleReadQrCodeSuccess(_ data: String) {
            captureSession.stopRunning()
            let formattedString = data.data(using: .utf8)!

            do {
                self.showAlertMessage(title: .Information, message: data)
            } catch {
                showAlertMessage(title: .None, message: "QR Code is not valid", actionTitle: "Ok") {[weak self] _
                    in
                    self?.captureSession.startRunning()
                }

            }
        }
    //MARK: - API

    deinit{
        print("Qrcode deinit")
    }

}
// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.

        if metadataObjects.count == 0 {
            // qrCodeFrameView?.frame = CGRect.zero
            debugPrint("No QR code is detected")
            return
        }

        // Get the metadata object.
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if let metaDataString = metadataObj.stringValue {
                print("success===> \(metaDataString)")
                 self.handleReadQrCodeSuccess(metaDataString)
            }
        }
    }
}
