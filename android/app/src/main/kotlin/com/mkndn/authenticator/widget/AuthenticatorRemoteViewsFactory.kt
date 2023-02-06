package com.mkndn.authenticator.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.*
import android.view.View
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory
import androidx.core.content.ContextCompat
import com.mkndn.authenticator.R
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import java.util.concurrent.Executor
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService

class AuthenticatorRemoteViewsFactory(context: Context?, intent: Intent) : RemoteViewsFactory {

    private var context: Context? = null
    private val appWidgetId: Int
    private var totpData: ArrayList<TotpData>
    private lateinit var appWidgetManager: AppWidgetManager

    override fun onCreate() {
        appWidgetManager = AppWidgetManager.getInstance(context!!)
    }

    override fun onDestroy() {
        totpData.clear()
    }

    override fun getCount(): Int {
        return totpData.size
    }

    override fun getViewAt(position: Int): RemoteViews {

        var code = TotpHandler.generateTOTP(
            totpData[position].secret, System.currentTimeMillis(),
            totpData[position].digits, totpData[position].algorithm
        )

        val row = RemoteViews(context!!.packageName, R.layout.totp_items).apply {
            setTextViewText(R.id.totp_code_text, code)
            setTextViewText(R.id.totp_label_text, totpData[position].label)
            setProgressBar(
                R.id.totp_progress, totpData[position].period,
                0, false
            )
            setTextViewText(R.id.totp_progress_text, "0")
        }

        Handler(Looper.getMainLooper()).postDelayed({
            while(true) {
                var i = totpData[position].period
                while (i >= 0) {
                    val updateRow = RemoteViews(context!!.packageName, R.layout.totp_items).apply {
                        setTextViewText(R.id.totp_code_text, code)
                        setTextViewText(R.id.totp_label_text, totpData[position].label)
                        setProgressBar(
                            R.id.totp_progress, totpData[position].period,
                            i, false
                        )
                        setTextViewText(
                            R.id.totp_progress_text,
                            i.toString()
                        )
                    }
                    if(i == totpData[position].period) {
                        appWidgetManager.updateAppWidget(appWidgetId, updateRow)
                    } else {
                        appWidgetManager.partiallyUpdateAppWidget(appWidgetId, updateRow)
                    }
                    try {
                        Thread.sleep(1000)
                    } catch (_: InterruptedException) {}
                    i--
                }
                code = TotpHandler.generateTOTP(
                    totpData[position].secret, System.currentTimeMillis(),
                    totpData[position].digits, totpData[position].algorithm
                )
            }

        }, 2000)

        val fillInIntent = Intent().apply {
            Bundle().also { extras ->
                extras.putString(
                    context!!.getString(AuthenticatorWidgetProvider.ITEM_CLICK),
                    code
                )
                putExtras(extras)
            }
        }
        row.setOnClickFillInIntent(R.id.totp_items, fillInIntent)

        return row;
    }

    override fun getLoadingView(): RemoteViews? {
        return null
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }

    override fun onDataSetChanged() {
        // no-op
    }

    init {
        this.context = context
        appWidgetId = intent.getIntExtra(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        )
        val totpJson = intent.getStringExtra(context!!.getString(R.string.totp_data)) ?: ""
        totpData = if (totpJson.isNotEmpty())
            Json.decodeFromString<ArrayList<TotpData>>(totpJson) else ArrayList()
    }
}