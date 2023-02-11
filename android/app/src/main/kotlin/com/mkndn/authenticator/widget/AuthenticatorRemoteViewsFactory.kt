package com.mkndn.authenticator.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.os.*
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory
import com.mkndn.authenticator.Extensions.clearData
import com.mkndn.authenticator.Extensions.getConverted
import com.mkndn.authenticator.Extensions.getInverse
import com.mkndn.authenticator.R
import es.antonborri.home_widget.HomeWidgetPlugin

class AuthenticatorRemoteViewsFactory(context: Context?, intent: Intent) : RemoteViewsFactory {

    private var context: Context? = null
    private val appWidgetId: Int
    private lateinit var totpWidgetData: TotpWidgetData
    private lateinit var appWidgetManager: AppWidgetManager
    private var widgetData: SharedPreferences
    private var isDataUpdated: Boolean? = null

    override fun onCreate() {
        appWidgetManager = AppWidgetManager.getInstance(context!!)
        totpWidgetData = getData()
        isDataUpdated = false
        clearData()
        totpWidgetData.data.forEach { item ->
            item.code = TotpHandler.generateTOTP(
                item.secret, System.currentTimeMillis(),
                item.digits, item.algorithm
            )
        }
    }

    override fun onDataSetChanged() {
        getData().also { updated ->
            if (updated.isUpdateFlow == true) {
                clearData()
                isDataUpdated = true
                totpWidgetData = updated
                if (totpWidgetData.data.isNotEmpty()) {
                    totpWidgetData.data.forEach { item ->
                        item.code = TotpHandler.generateTOTP(
                            item.secret, System.currentTimeMillis(),
                            item.digits, item.algorithm
                        )
                    }
                }
            }
        }
        totpWidgetData.data.forEach { item ->
            item.progress -= 1
            if (item.progress <= 0) {
                item.progress = item.period
                item.code = TotpHandler.generateTOTP(
                    item.secret, System.currentTimeMillis(),
                    item.digits, item.algorithm
                )
            }
        }
    }


    override fun getCount(): Int {
        return totpWidgetData.data.size
    }

    override fun getLoadingView(): RemoteViews? {
        return null
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return totpWidgetData.data[position].id.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }

    override fun getViewAt(position: Int): RemoteViews {
        return RemoteViews(context!!.packageName, R.layout.totp_items).apply {
            if (isDataUpdated == false) {
                isDataUpdated = null
                val textColor = totpWidgetData.bgColor?.let {
                    Color.valueOf(Color.parseColor(it)).getInverse()
                } ?: Color.valueOf(context!!.getColor(R.color.widget_bg)).getInverse()

                setInt(R.id.title_text, "setTextColor", textColor)
                setInt(R.id.totp_label_text, "setTextColor", textColor)
                setInt(R.id.totp_code_text, "setTextColor", textColor)
                setInt(R.id.totp_progress_text, "setTextColor", textColor)
                setTextViewText(R.id.totp_label_text, totpWidgetData.data[position].label)

                val fillInIntent = Intent().apply {
                    Bundle().also { extras ->
                        extras.putString(
                            context!!.getString(AuthenticatorWidgetProvider.ITEM_CLICK),
                            totpWidgetData.data[position].code
                        )
                        putExtras(extras)
                    }
                }
                setOnClickFillInIntent(R.id.totp_items, fillInIntent)
            }

            setTextViewText(R.id.totp_code_text, totpWidgetData.data[position].code)
            setProgressBar(
                R.id.totp_progress, totpWidgetData.data[position].period,
                totpWidgetData.data[position].progress, false
            )
            setTextViewText(
                R.id.totp_progress_text,
                totpWidgetData.data[position].progress.toString()
            )
        }
    }

    override fun onDestroy() {
        totpWidgetData.data.clear()
    }

    private fun getData(): TotpWidgetData {
        return widgetData.getConverted(context!!.getString(R.string.widget_data), TotpWidgetData())
    }

    private fun clearData() = widgetData.clearData(context!!.getString(R.string.widget_data))

    init {
        this.context = context
        widgetData = HomeWidgetPlugin.getData(context!!)
        appWidgetId = intent.getIntExtra(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        )
    }
}