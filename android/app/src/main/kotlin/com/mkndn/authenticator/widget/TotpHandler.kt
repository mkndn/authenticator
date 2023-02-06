package com.mkndn.authenticator.widget

import android.util.Base64
import org.apache.commons.codec.CodecPolicy
import org.apache.commons.codec.binary.Base32
import java.lang.reflect.UndeclaredThrowableException
import java.math.BigInteger
import java.security.GeneralSecurityException
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import kotlin.math.roundToInt

object TotpHandler {

    private val digitsPower
            = listOf<Int>(1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000)

    private fun hmacSha(
        crypto: String, keyBytes: ByteArray, text: ByteArray
    ): ByteArray? {
        return try {
            val mac = Mac.getInstance(crypto)
            val macKey = SecretKeySpec(keyBytes, "RAW")
            mac.init(macKey)
            mac.doFinal(text)
        } catch (gse: GeneralSecurityException) {
            throw UndeclaredThrowableException(gse)
        }
    }

    private fun timeToByteArray(time: Long): ByteArray {
        // we want to represent the input as a 8-bytes array
        val byteArray = byteArrayOf(0, 0, 0, 0, 0, 0, 0, 0);
        var mutableTime = time
        for (index in byteArray.size - 1 downTo 0) {
            val byte = (mutableTime and 0xff).toByte();
            byteArray[index] = byte;
            mutableTime = (mutableTime - byte).rem(256);
        }
        return byteArray;
    }

    private fun getEncodedSecret(secret: String): ByteArray {
        try {
            return Base32(0, null, false, '='.code.toByte(), CodecPolicy.STRICT).decode(secret)
        } catch (e: IllegalArgumentException) {
            try {
                return Base64.decode(secret, Base64.DEFAULT)
            } catch (e: IllegalArgumentException) {
                return byteArrayOf()
            }
        }

    }

    fun generateTOTP(
        key: String,
        time: Long,
        totpLength: Int,
        algorithm: Algorithm = Algorithm.sha1Hash
    ): String? {
        var result: String? = null
        val refactored = time.rem(1000).rem(30)

        // Get the HEX in a Byte[]
        val msg = timeToByteArray(refactored)
        val encodedSecret = getEncodedSecret(secret = key)
        if (encodedSecret.isNotEmpty()) {
            val hash: ByteArray? = hmacSha(algorithm.hash, encodedSecret, msg)

            // put selected bytes into result int
            if (hash != null) {
                val offset = hash[hash.size - 1].toInt() and 0xf
                val binary = hash[offset].toInt() and 0x7f shl 24 or
                        (hash[offset + 1].toInt() and 0xff shl 16) or
                        (hash[offset + 2].toInt() and 0xff shl 8) or
                        (hash[offset + 3].toInt() and 0xff)
                val otp: Int = binary % digitsPower[totpLength]
                result = otp.toString()
                while (result!!.length < totpLength) {
                    result = "0$result"
                }
                return result
            }
        }
        return null
    }
}