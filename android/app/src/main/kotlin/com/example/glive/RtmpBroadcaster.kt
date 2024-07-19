package com.example.glive
import android.content.Context
import android.util.AttributeSet
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.widget.Toast
import net.ossrs.rtmp.ConnectCheckerRtmp;
import net.ossrs.rtmp.SrsFlvMuxer;

class RtmpBroadcaster  @JvmOverloads constructor(
    private val mainActivity: MainActivity, context: Context, attrs: AttributeSet? = null
) : SurfaceView(context, attrs), SurfaceHolder.Callback, ConnectCheckerRtmp {
    private val srsFlvMuxer = SrsFlvMuxer(this)

    init {
        holder.addCallback(this)
    }

    fun startStream(url: String) {
        srsFlvMuxer.start(url)
    }

    fun stopStream() {
        srsFlvMuxer.stop()
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        // Start camera preview or any other initializations
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        // Handle surface changes if needed
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        // Release resources
    }

   override fun onConnectionSuccessRtmp() {
        // Handle successful connection
       mainActivity.sendEventToFlutter("onConnectionSuccess")
        Toast.makeText(context, "RTMP connection successful", Toast.LENGTH_SHORT).show()
    }

    override fun onConnectionFailedRtmp(reason: String) {
        // Handle connection failure
        mainActivity.sendEventToFlutter("onConnectionFailed", reason)
        Toast.makeText(context, "RTMP connection failed: $reason", Toast.LENGTH_SHORT).show()
        stopStream()
    }

    override fun onNewBitrateRtmp(bitrate: Long) {
        TODO("Not yet implemented")
    }

    override fun onDisconnectRtmp() {
        // Handle disconnection
        mainActivity.sendEventToFlutter("onDisconnect")
        Toast.makeText(context, "RTMP disconnected", Toast.LENGTH_SHORT).show()
    }

    override fun onAuthErrorRtmp() {
        // Handle authentication error
        mainActivity.sendEventToFlutter("onAuthError")
        Toast.makeText(context, "RTMP authentication error", Toast.LENGTH_SHORT).show()
    }

    override fun onAuthSuccessRtmp() {
        // Handle authentication success
        mainActivity.sendEventToFlutter("onAuthSuccess")
        Toast.makeText(context, "RTMP authentication successful", Toast.LENGTH_SHORT).show()
    }


}

