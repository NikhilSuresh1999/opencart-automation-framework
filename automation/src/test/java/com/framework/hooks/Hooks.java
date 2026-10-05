package com.framework.hooks;

import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

import com.framework.utils.DriverFactory;
import io.cucumber.java.Scenario;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

public class Hooks {

  private DriverFactory factory;
  private WebDriver driver;

  @Before
  public void setup() {
      factory = new DriverFactory();
      driver = factory.initDriver();
  }

  @After(order = 1)
  public void takeScreenshotOnFailure(Scenario scenario) {
      if (scenario.isFailed()) {
          byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
          scenario.attach(screenshot, "image/png", scenario.getName());
      }
  }

  @After(order = 0)
  public void tearDown() {
      if (driver != null) {
          driver.quit();
          DriverFactory.tlDriver.remove();
      }
  }
  
}
