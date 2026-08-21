package com.ruoyi.vlstream.service;

import org.apache.commons.lang3.StringUtils;

public final class FirmwareVersion {
    private FirmwareVersion() { }

    public static boolean isValid(String value) {
        return StringUtils.isNotBlank(value) && value.matches("(0|[1-9]\\d*)(\\.(0|[1-9]\\d*)){2,}");
    }

    public static boolean isGreater(String candidate, String current) {
        if (!isValid(candidate) || !isValid(current)) return false;
        String[] left = candidate.split("\\.");
        String[] right = current.split("\\.");
        int length = Math.max(left.length, right.length);
        for (int i = 0; i < length; i++) {
            java.math.BigInteger a = new java.math.BigInteger(i < left.length ? left[i] : "0");
            java.math.BigInteger b = new java.math.BigInteger(i < right.length ? right[i] : "0");
            int compared = a.compareTo(b);
            if (compared != 0) return compared > 0;
        }
        return false;
    }
}
