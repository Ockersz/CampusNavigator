import SwiftUI
import AVFoundation

struct QRScannerView: View {
    @StateObject private var scanner = QRScannerViewModel()
   
    var body: some View {
        VStack(spacing: 20) {
            Text("Scan QR Code")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading,5)
           
            // QR Camera Preview
            ZStack {
                QRScannerPreview(session: scanner.session)
                    .frame(width: 350, height: 300)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
               
                if scanner.isScanning {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
            }
           
            Text("Center your camera to the QR code clearly to scan.")
                .font(.subheadline)
           
            Spacer()
        }
        .padding()
        .onAppear {
            scanner.startScanning()
        }
        .onDisappear {
            scanner.stopScanning()
        }
    }
}

// QR Scanner Preview
struct QRScannerPreview: UIViewControllerRepresentable {
    let session: AVCaptureSession
   
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        controller.view.layer.addSublayer(previewLayer)
        return controller
    }
   
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// QR Scanner ViewModel
class QRScannerViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var isScanning = true
    var session = AVCaptureSession()
   
    override init() {
        super.init()
        setupScanner()
    }
   
    func setupScanner() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
       
        let output = AVCaptureMetadataOutput()
        session.addInput(input)
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
    }
   
    func startScanning() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }
   
    func stopScanning() {
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()
        }
    }
   
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let scannedCode = metadataObject.stringValue {
            print("Scanned QR Code: \(scannedCode)")
            stopScanning()
        }
    }
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView()
    }
}

