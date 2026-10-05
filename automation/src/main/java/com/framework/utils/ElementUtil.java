package com.framework.utils;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class ElementUtil {
  private WebDriver driver;
  private WebDriverWait wait;

  public ElementUtil(WebDriver driver){
    this.driver = driver;
    this.wait = new WebDriverWait(driver, Duration.ofSeconds(15));
  }

  public void click(By locator){
    try{
      wait.until(ExpectedConditions.elementToBeClickable(locator)).click();
    }catch(Exception e){
      clickWithJS(locator);
    }
  }

  public void clickWithJS(By locator){
    WebElement element = wait.until(ExpectedConditions.presenceOfElementLocated(locator));
    ((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
  }

  public void type(By locator, String text) {
        WebElement el = wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
        el.clear();
        if (text != null && !text.isEmpty()) {
            el.sendKeys(text);
        }
    }

    public void selectByVisibleText(By locator, String text) {
        new Select(wait.until(ExpectedConditions.visibilityOfElementLocated(locator))).selectByVisibleText(text);
    }

    public void waitForOptionPresent(By locator, String optionText) {
        try {
            wait.until(d -> {
                Select s = new Select(d.findElement(locator));
                for (WebElement opt : s.getOptions()) {
                    if (opt.getText().trim().equalsIgnoreCase(optionText.trim())) {
                        return true;
                    }
                }
                return false;
            });
        } catch (Exception e) {
            // Proceed if wait times out
        }
    }

    public void selectByValue(By locator, String value) {
        new Select(wait.until(ExpectedConditions.visibilityOfElementLocated(locator))).selectByValue(value);
    }

    public void scrollToElement(By locator) {
        try {
            WebElement el = wait.until(ExpectedConditions.presenceOfElementLocated(locator));
            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({block: 'center'});", el);
        } catch (Exception e) {
            // Ignored
        }
    }

    public String getTextSafely(By locator) {
        try {
            return wait.until(ExpectedConditions.visibilityOfElementLocated(locator)).getText();
        } catch (Exception e) {
            return "";
        }
    }

    public boolean isElementDisplayed(By locator) {
        try {
            return wait.until(ExpectedConditions.visibilityOfElementLocated(locator)).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public void waitForAjaxToComplete() {
        try {
            wait.until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector(".fa-spinner, .spinner-border")));
        } catch (Exception e) {
            // Spinner not present or already disappeared
        }
    }
}
