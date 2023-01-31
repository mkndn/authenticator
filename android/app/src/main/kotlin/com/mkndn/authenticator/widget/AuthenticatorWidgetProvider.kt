package com.mkndn.authenticator.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.mkndn.authenticator.MainActivity
import com.mkndn.authenticator.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import android.os.Build

class AuthenticatorWidgetProvider : HomeWidgetProvider() {

    companion object {
        const val ITEM_CLICK = R.string.item_cta_key
        const val ACTION_CLICK = R.string.action_click
    }

    override fun onReceive(context: Context?, intent: Intent?) {

            Intent(context, MainActivity::class.java).apply {
                action = context?.getString(R.string.app_widget_launch_action)
                data = Uri.parse("${context?.getString(R.string.app_widget_card_clicked_uri)}")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context?.startActivity(this)
            }
        super.onReceive(context, intent)

    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.authenticator).apply {

                //fetch data from flutter
                val totpData = widgetData.getString(context.getString(R.string.totp_data), null)

                // Open App on Widget Click
                val dataIntent = Intent(context, AuthenticatorWidgetService::class.java)
                dataIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                dataIntent.data = Uri.parse(dataIntent.toUri(Intent.URI_INTENT_SCHEME))
                dataIntent.putExtra(context.getString(R.string.totp_data), totpData)

                setRemoteAdapter(R.id.totp_list, dataIntent)

                // Detect App opened via Click inside Flutter
                val clickPendingIntent: PendingIntent = Intent(
                    context,
                    AuthenticatorWidgetProvider::class.java
                ).run {
                    action = context.getString(ACTION_CLICK)
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                    data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))

                    var flags = PendingIntent.FLAG_UPDATE_CURRENT
                    if (Build.VERSION.SDK_INT >= 23) {
                        flags = flags or PendingIntent.FLAG_IMMUTABLE
                    }

                    PendingIntent.getBroadcast(context, 0, this,  flags)
                }
                setPendingIntentTemplate(R.id.totp_list,clickPendingIntent)
                appWidgetManager.updateAppWidget(widgetId, this)
            }
        }
    }

}