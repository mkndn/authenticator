package com.mkndn.authenticator.widget

enum class Algorithm(val hash: String) {
    sha1Hash("HmacSHA1"),
    sha256Hash("HmacSHA256"),
    sha512Hash("HmacSHA512");
}