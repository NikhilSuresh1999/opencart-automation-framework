// package com.framework.utils;

// import org.openqa.selenium.WebDriver;
// import org.openqa.selenium.chrome.ChromeDriver;
// import org.openqa.selenium.chrome.ChromeOptions;
// import java.time.Duration;

// public class DriverFactory {
//     public static ThreadLocal<WebDriver> tlDriver = new ThreadLocal<>();

//     public WebDriver initDriver() {
//         ChromeOptions options = new ChromeOptions();
//       //  options.addArguments("--incognito", "--window-size=1920,1080", "--disable-notifications");
//        options.addArguments("--window-size=1920,1080", "--disable-notifications");
        
//         tlDriver.set(new ChromeDriver(options)); // Fix 1: ChromeDriver is now imported above
        
//         getDriver().manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
//         getDriver().manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30)); // Fix 2: Removed the "s"
        
//         return getDriver();
//     }

//     public static synchronized WebDriver getDriver() {
//         return tlDriver.get();
//     }
// }

package com.framework.utils;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import java.time.Duration;
import java.util.Collections;

public class DriverFactory {
    public static ThreadLocal<WebDriver> tlDriver = new ThreadLocal<>();

    public WebDriver initDriver() {
        // Read browser from terminal command, default to chrome if null
        String browser = System.getProperty("browser", "chrome").toLowerCase();

        switch (browser) {
            case "firefox":
                tlDriver.set(new FirefoxDriver());
                break;
            case "edge":
                tlDriver.set(new EdgeDriver());
                break;
            case "chrome":
            default:
                ChromeOptions options = new ChromeOptions();
                options.setExperimentalOption("excludeSwitches", Collections.singletonList("enable-automation"));
                options.setExperimentalOption("useAutomationExtension", false);
                options.addArguments("--disable-blink-features=AutomationControlled");
                options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36");
                options.addArguments("--incognito", "--window-size=1920,1080", "--disable-notifications");
                // Uncomment the line below to run in headless mode in CI/CD pipelines
                // options.addArguments("--headless=new");
                tlDriver.set(new ChromeDriver(options));
                break;
        }

        getDriver().manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
        getDriver().manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30));
        return getDriver();
    }

    public static synchronized WebDriver getDriver() {
        return tlDriver.get();
    }
}