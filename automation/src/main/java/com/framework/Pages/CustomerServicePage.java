package com.framework.Pages;

import com.framework.utils.ElementUtil;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class CustomerServicePage {
    private WebDriver driver;
    private ElementUtil ele;

    // Contact Us Locators
    private By contactNameInput = By.id("input-name");
    private By contactEmailInput = By.id("input-email");
    private By contactEnquiryInput = By.id("input-enquiry");
    private By contactSubmitBtn = By.xpath("//input[@value='Submit']");
    private By contactSuccessText = By.xpath("//div[@id='content']//p[contains(text(),'Your enquiry has been successfully sent')]");
    
    // Product Returns Locators
    private By returnFirstNameInput = By.id("input-firstname");
    private By returnLastNameInput = By.id("input-lastname");
    private By returnEmailInput = By.id("input-email");
    private By returnTelephoneInput = By.id("input-telephone");
    private By returnOrderIdInput = By.id("input-order-id");
    private By returnProductInput = By.id("input-product");
    private By returnModelInput = By.id("input-model");
    private By returnSubmitBtn = By.xpath("//input[@value='Submit']");
    private By returnSuccessHeading = By.xpath("//div[@id='content']//h1");

    // Generic Information / Validation
    private By textDanger = By.cssSelector(".text-danger");
    private By contentHeading = By.xpath("//div[@id='content']//h1");
    private By sitemapContainer = By.xpath("//div[@id='content']//div[contains(@class,'col-sm-6')]");

    public CustomerServicePage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
    }

    public void navigateToContactUs() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=information/contact");
        ele.waitForAjaxToComplete();
    }

    public void submitContactForm(String name, String email, String enquiry) {
        navigateToContactUs();
        ele.type(contactNameInput, name);
        ele.type(contactEmailInput, email);
        ele.type(contactEnquiryInput, enquiry);
        ele.click(contactSubmitBtn);
        ele.waitForAjaxToComplete();
    }

    public boolean isContactSuccessDisplayed() {
        return driver.getCurrentUrl().contains("information/contact/success")
            || ele.isElementDisplayed(By.id("common-success"))
            || ele.isElementDisplayed(contactSuccessText);
    }

    public void navigateToReturns() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=account/return/add");
        ele.waitForAjaxToComplete();
    }

    public void submitReturnForm(String fName, String lName, String email, String phone, String orderId, String product, String model, int reasonId) {
        navigateToReturns();
        ele.type(returnFirstNameInput, fName);
        ele.type(returnLastNameInput, lName);
        ele.type(returnEmailInput, email);
        ele.type(returnTelephoneInput, phone);
        ele.type(returnOrderIdInput, orderId);
        ele.type(returnProductInput, product);
        ele.type(returnModelInput, model);
        if (reasonId >= 1 && reasonId <= 5) {
            ele.click(By.xpath("//input[@name='return_reason_id' and @value='" + reasonId + "']"));
        }
        ele.click(returnSubmitBtn);
        ele.waitForAjaxToComplete();
    }

    public boolean isReturnSuccessDisplayed() {
        return driver.getCurrentUrl().contains("account/return/success")
            || ele.isElementDisplayed(returnSuccessHeading);
    }

    public boolean isValidationErrorDisplayed() {
        return ele.isElementDisplayed(textDanger);
    }

    public String getValidationErrorMessage() {
        return ele.getTextSafely(textDanger);
    }

    public void navigateToInformationPage(int informationId) {
        driver.get("https://tutorialsninja.com/demo/index.php?route=information/information&information_id=" + informationId);
        ele.waitForAjaxToComplete();
    }

    public String getContentHeading() {
        return ele.getTextSafely(contentHeading);
    }

    public void navigateToSitemap() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=information/sitemap");
        ele.waitForAjaxToComplete();
    }

    public boolean isSitemapDisplayed() {
        return ele.isElementDisplayed(sitemapContainer);
    }
}

