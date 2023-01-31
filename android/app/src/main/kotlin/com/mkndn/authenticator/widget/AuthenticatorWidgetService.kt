package com.mkndn.authenticator.widget

import android.content.Intent
import android.widget.RemoteViewsService

class AuthenticatorWidgetService: RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return AuthenticatorRemoteViewsFactory(
            this.applicationContext, intent
        );
    }
}