package com.framework.Pages;

import com.framework.utils.ElementUtil;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class ComparisonPage {
    private WebDriver driver;
    private ElementUtil ele;

    private By comparisonTable = By.xpath("//table[contains(@class,'table-bordered')]");
    private By productNames = By.xpath("//table[contains(@class,'table-bordered')]//strong/a");
    private By removeBtn = By.xpath("//a[contains(@href, 'remove=')]");
    private By emptyComparisonMsg = By.xpath("//div[@id='content']//p[contains(text(),'You have not chosen any products to compare.')]");
    private By alertSuccess = By.cssSelector(".alert-success");

    public ComparisonPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
    }

    public void navigateToComparison() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=product/compare");
        ele.waitForAjaxToComplete();
    }

    public boolean isComparisonTableDisplayed() {
        return ele.isElementDisplayed(comparisonTable);
    }

    public String getFirstProductName() {
        return ele.getTextSafely(productNames);
    }

    public void removeProduct() {
        ele.click(removeBtn);
        ele.waitForAjaxToComplete();
    }

    public boolean isEmptyComparisonMessageDisplayed() {
        return ele.isElementDisplayed(emptyComparisonMsg);
    }

    public String getAlertText() {
        return ele.getTextSafely(alertSuccess);
    }
}

