package com.silverfox.finance.util;

import java.awt.GraphicsEnvironment;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

public class SystemUtil {
	public static List<String> getAvailableFont() {
		List<String> fonts = new LinkedList<String>();
		GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
		String[] fontNames = environment.getAvailableFontFamilyNames();
		if (fontNames != null && fontNames.length > 0) {
			for (String fontName : fontNames) {
				fonts.add(fontName);
			}
		}
		return fonts;
	}

	public static String getSystemProperty(String propertyName) {
		return System.getProperty(propertyName);
	}

	public static Properties getSystemProperties() {
		return System.getProperties();
	}
}