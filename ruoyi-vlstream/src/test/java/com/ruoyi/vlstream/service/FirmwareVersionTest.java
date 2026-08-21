package com.ruoyi.vlstream.service;

import org.junit.Test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class FirmwareVersionTest {
    @Test
    public void comparesNumericSegments() {
        assertTrue(FirmwareVersion.isGreater("1.0.1.20", "1.0.1.9"));
        assertTrue(FirmwareVersion.isGreater("1.10.0", "1.9.99"));
        assertFalse(FirmwareVersion.isGreater("1.0.0", "1.0.0.0"));
        assertFalse(FirmwareVersion.isValid("v1.2.3"));
    }
}
