package com.addcn.fluttershare

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.webkit.*
import androidx.annotation.RequiresApi
import android.content.Intent
import android.net.Uri
import android.widget.Toast


class WebViewActivity : Activity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(this)
        val webSettings = webView.settings
        /**支持Js**/
        webSettings.javaScriptEnabled = true;
        /**设置自适应屏幕，二者合用**/
        //将图片调整到适合webview的大小
        webSettings.useWideViewPort = true;
        // 缩放至屏幕的大小
        webSettings.loadWithOverviewMode = true;
        /**缩放操做**/
        // 是否支持画面缩放，默认不支持
        webSettings.builtInZoomControls = true;
        webSettings.setSupportZoom(true);
        // 是否显示缩放图标，默认显示
        webSettings.displayZoomControls = false;
        // 设置网页内容自适应屏幕大小
        webSettings.layoutAlgorithm = WebSettings.LayoutAlgorithm.SINGLE_COLUMN;
        /**设置容许JS弹窗**/
        webSettings.javaScriptCanOpenWindowsAutomatically = true;
        webSettings.domStorageEnabled = true;
        /**关闭webview中缓存**/
        webSettings.cacheMode = WebSettings.LOAD_NO_CACHE;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webSettings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
        webView.webChromeClient = WebChromeClient()
        webView.webViewClient = WebViewClient()
        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                if (!(url.startsWith("http://") || url.startsWith("https://"))) {
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                    if (intent.resolveActivity(packageManager) != null) {
                        startActivity(intent)
                    } else {
                        Toast.makeText(this@WebViewActivity, "請下載App後嘗試", Toast.LENGTH_SHORT).show()
                    }
                    return true
                }
                view.loadUrl(url)
                return true
            }
            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
                val url: String = request.url.toString()
                if (!(url.startsWith("http://") || url.startsWith("https://"))) {
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                    if (intent.resolveActivity(packageManager) != null) {
                        startActivity(intent)
                    } else {
                        Toast.makeText(this@WebViewActivity, "請下載App後嘗試", Toast.LENGTH_SHORT).show()
                    }
                    return true
                }
                view.loadUrl(url)
                return true
            }
        }
        setContentView(webView)
        val text: String? = intent.getStringExtra("text")
        webView.loadUrl("$text")
    }
}