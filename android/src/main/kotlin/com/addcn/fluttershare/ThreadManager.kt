package com.addcn.fluttershare

import android.os.Handler
import android.os.Looper

object ThreadManager {
    private var mainHandler: Handler? = null
    private val mainHandlerLock = Any()

    fun getMainHandler(): Handler? {
        if (mainHandler == null) {
            synchronized(mainHandlerLock) {
                mainHandler = Handler(Looper.getMainLooper())
            }
        }
        return mainHandler
    }
}