package com.mkndn.authenticator.widget

@kotlinx.serialization.Serializable
data class TotpData(val id: String,
                    val algorithm: Algorithm,
                    val period: Int,
                    val digits: Int,
                    val label: String,
                    val issuer: String,
                    val secret: String)
