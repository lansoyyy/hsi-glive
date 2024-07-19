import HaishinKit
import AVFoundation
import VideoToolbox

class RTMPBroadcaster: UIView {
    var rtmpConnection = RTMPConnection()
    var rtmpStream: RTMPStream!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStream()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStream()
    }

    private func setupStream() {
        rtmpStream = RTMPStream(connection: rtmpConnection)
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio)) { error in
            // Handle error
        }
        rtmpStream.attachCamera(DeviceUtil.device(withPosition: .back)) { error in
            // Handle error
        }
    }

    func startStream(url: String) {
        rtmpConnection.connect(url)
        rtmpStream.publish("streamName")
    }

    func stopStream() {
        rtmpStream.close()
        rtmpConnection.close()
    }
}
