package com.mkndn.authenticator.widget

import android.graphics.Color

@kotlinx.serialization.Serializable
data class TotpWidgetData(
    val data: ArrayList<TotpData> = arrayListOf(),
    val totalAccounts: Int = 0,
    val bgColor: String? = null,
    val textColor: String? = null,
    val isUpdateFlow: Boolean? = null,
)

@kotlinx.serialization.Serializable
data class TotpData(val id: String,
                    val algorithm: Algorithm,
                    val period: Int,
                    val digits: Int,
                    val label: String,
                    val issuer: String,
                    val secret: String,
                    var code: String? = null,
                    var progress: Int = period)
