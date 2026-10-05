package com.framework.utils;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import java.time.Duration;

public class DriverFactory {
    public static ThreadLocal<WebDriver> tlDriver = new ThreadLocal<>();

    public WebDriver initDriver() {
        ChromeOptions options = new ChromeOptions();
      //  options.addArguments("--incognito", "--window-size=1920,1080", "--disable-notifications");
       options.addArguments("--window-size=1920,1080", "--disable-notifications");
        
        tlDriver.set(new ChromeDriver(options)); // Fix 1: ChromeDriver is now imported above
        
        getDriver().manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
        getDriver().manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30)); // Fix 2: Removed the "s"
        
        return getDriver();
    }

    public static synchronized WebDriver getDriver() {
        return tlDriver.get();
    }
}