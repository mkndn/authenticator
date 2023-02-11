package com.mkndn.authenticator.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.widget.RemoteViews
import com.mkndn.authenticator.Extensions.getConverted
import com.mkndn.authenticator.Extensions.getInverse
import com.mkndn.authenticator.MainActivity
import com.mkndn.authenticator.R
import es.antonborri.home_widget.HomeWidgetProvider
import kotlinx.coroutines.*

class AuthenticatorWidgetProvider : HomeWidgetProvider() {

    private var job: Job? = null

    companion object {
        const val ITEM_CLICK = R.string.item_cta_key
        const val ACTION_CLICK = R.string.action_click
        const val OPEN_APP = R.string.open_app
    }

    override fun onEnabled(context: Context?) {
        super.onEnabled(context)
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == context?.getString(ACTION_CLICK) || intent?.action == context?.getString(OPEN_APP)) {
            val cta: String? = intent?.getStringExtra(context?.getString(ITEM_CLICK))
            Intent(context, MainActivity::class.java).apply {
                action = context?.getString(R.string.app_widget_launch_action)
                data =
                    Uri.parse("${context?.getString(R.string.app_widget_item_clicked_uri)}?${cta}")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context?.startActivity(this)
            }
        }
        super.onReceive(context, intent)

    }

    @OptIn(DelicateCoroutinesApi::class)
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            RemoteViews(context.packageName, R.layout.authenticator).apply {
                //fetch data from flutter

                val totpWidgetData = widgetData.getConverted<TotpWidgetData>(
                    context.getString(R.string.widget_data), TotpWidgetData()
                )

                if (totpWidgetData.isUpdateFlow == true) {
                    job?.let {
                        it.cancel("Cancelling during update")
                    }
                } else {
                    // Open App on Widget Click
                    val dataIntent = Intent(context, AuthenticatorWidgetService::class.java).apply {
                        putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                        data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
                    }

                    totpWidgetData.bgColor?.let {
                        val backgroundColor = Color.parseColor(it)
                        setInt(R.id.widget_container, "setBackgroundColor", backgroundColor)
                        setInt(R.id.title_text, "setTextColor", Color.valueOf(backgroundColor).getInverse())
                    } ?: {
                        val backgroundColorConfigured = context.getColor(R.color.widget_bg)
                        setInt(R.id.widget_container, "setBackgroundColor", backgroundColorConfigured)
                        setInt(R.id.title_text, "setTextColor", Color.valueOf(backgroundColorConfigured).getInverse())
                    }

                    setFloat(R.id.widget_container, "setAlpha", 1.0f)

                    setRemoteAdapter(R.id.totp_list, dataIntent)
                    setEmptyView(R.id.totp_list, R.id.empty_view)

                    var flags = PendingIntent.FLAG_UPDATE_CURRENT
                    flags = flags or PendingIntent.FLAG_IMMUTABLE

                    val openAppIntent = Intent(context, AuthenticatorWidgetProvider::class.java)
                    openAppIntent.action = context.getString(OPEN_APP)
                    openAppIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)

                    val openAppPendingIntent = PendingIntent.getBroadcast(
                        context, 0,  openAppIntent, flags)
                    setOnClickPendingIntent(R.id.btn_open_app, openAppPendingIntent)

                    // Detect App opened via Click inside Flutter
                    val clickPendingIntent: PendingIntent = Intent(
                        context,
                        AuthenticatorWidgetProvider::class.java
                    ).run {
                        action = context.getString(ACTION_CLICK)
                        putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                        data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))

                        var flags = PendingIntent.FLAG_UPDATE_CURRENT
                        flags = flags or PendingIntent.FLAG_IMMUTABLE

                        PendingIntent.getBroadcast(context, 0, this, flags)
                    }
                    setPendingIntentTemplate(R.id.totp_list, clickPendingIntent)
                    appWidgetManager.updateAppWidget(widgetId, this)
                }

                job = GlobalScope.launch(Dispatchers.Main, CoroutineStart.DEFAULT) {
                    coroutineScope {
                        while (true) {
                            appWidgetManager.notifyAppWidgetViewDataChanged(
                                widgetId,
                                R.id.totp_list
                            )
                            delay(1000)
                        }
                    }
                }
            }
        }
    }
}