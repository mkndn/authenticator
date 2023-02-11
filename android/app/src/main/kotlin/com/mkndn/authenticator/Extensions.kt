package com.mkndn.authenticator

import android.content.SharedPreferences
import android.graphics.Color
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import kotlin.math.pow

object Extensions {
   inline fun <reified T> String?.jsonParse(defaultValue: T?): T? {
      val jsonConfig = Json { encodeDefaults = false }
      return if (this != null) jsonConfig.decodeFromString<T>(this) else defaultValue
   }

   inline fun <reified T> SharedPreferences.getConverted(key: String, defaultReturnValue: T): T {
      val stringValue = this.getString(key, null)
      return if (stringValue != null) {
         stringValue.jsonParse(defaultReturnValue)!!
      } else
      defaultReturnValue;
   }

   fun SharedPreferences.clearData(key: String): Unit {
      this.edit().remove(key).apply()
   }

   inline fun <reified T> SharedPreferences.getConvertedNullable(key: String, defaultReturnValue: T?): T? {
      val stringValue = this.getString(key, null)
      return if (stringValue != null) {
         stringValue.jsonParse(defaultReturnValue)
      } else
         defaultReturnValue;
   }

   fun Color.getInverse(): Int {
     return if(0.2126 * this.red() + 0.7151 * this.green() + 0.0721 * this.blue() < 140)
        Color.WHITE;
     else
        Color.BLACK;
   }
}