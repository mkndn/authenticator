package com.mkndn.authenticator.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.RemoteViews
import android.widget.RemoteViewsService.RemoteViewsFactory
import com.mkndn.authenticator.R

class AuthenticatorRemoteViewsFactory(context: Context?, intent: Intent): RemoteViewsFactory {

    private var context: Context? = null
    private val appWidgetId: Int
    private var totpData:  ArrayList<String>

    override fun onCreate() {}

    override fun onDestroy() {
        totpData.clear()
    }

    override fun getCount(): Int {
        return totpData.size
    }

    override fun getViewAt(position: Int): RemoteViews {
        val row = RemoteViews(context!!.packageName, R.layout.totp_items).apply {
            setTextViewText(R.id.totp_code_text, totpData[position])
        }
        Intent().apply {
            val extras = Bundle()
            extras.putString(context!!.getString(AuthenticatorWidgetProvider.ITEM_CLICK), totpData[position])
            row.setOnClickFillInIntent(R.id.totp_items, this)
        }
        return  row
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
        appWidgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
        val totpListData = intent.getStringExtra(context!!.getString(R.string.totp_data))?.split(",") ?: ArrayList()
        totpData  = ArrayList(totpListData)
    }
}