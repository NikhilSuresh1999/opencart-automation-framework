package com.framework.Pages;

import com.framework.utils.ElementUtil;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;

public class CartPage {

    private WebDriver driver;
    private ElementUtil ele;

    private By cartTableRows = By.xpath("//div[@id='content']//form//tbody/tr");
    private By firstRowQtyInput = By.xpath("//div[@id='content']//form//tbody/tr[1]//input[contains(@name,'quantity')]");
    private By firstRowUpdateBtn = By.xpath("//div[@id='content']//form//tbody/tr[1]//button[@data-original-title='Update' or @type='submit']");
    private By firstRowRemoveBtn = By.xpath("//div[@id='content']//form//tbody/tr[1]//button[@data-original-title='Remove' or contains(@onclick,'cart.remove')]");
    
    // Accordions
    private By couponAccordion = By.xpath("//a[contains(text(),'Use Coupon Code')]");
    private By couponInput = By.id("input-coupon");
    private By couponApplyBtn = By.id("button-coupon");

    private By voucherAccordion = By.xpath("//a[contains(text(),'Use Gift Certificate')]");
    private By voucherInput = By.id("input-voucher");
    private By voucherApplyBtn = By.id("button-voucher");

    private By shippingAccordion = By.xpath("//a[contains(text(),'Estimate Shipping & Taxes')]");
    private By shippingCountryDropdown = By.id("input-country");
    private By shippingZoneDropdown = By.id("input-zone");
    private By shippingPostcodeInput = By.id("input-postcode");
    private By getQuotesBtn = By.id("button-quote");

    private By alertSuccess = By.cssSelector(".alert-success");
    private By alertDanger = By.cssSelector(".alert-danger");
    private By emptyCartMsg = By.xpath("//div[@id='content']//p[contains(text(),'Your shopping cart is empty!')]");
    private By checkoutBtn = By.xpath("//a[normalize-space()='Checkout']");

    public CartPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
    }

    public void navigateToCart() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=checkout/cart");
        ele.waitForAjaxToComplete();
    }

    public void updateFirstItemQuantity(String qty) {
        ele.type(firstRowQtyInput, qty);
        ele.click(firstRowUpdateBtn);
        ele.waitForAjaxToComplete();
        ele.isElementDisplayed(alertSuccess);
    }

    public void removeFirstItem() {
        ele.click(firstRowRemoveBtn);
        ele.waitForAjaxToComplete();
    }

    public void applyCoupon(String couponCode) {
        ele.click(couponAccordion);
        ele.type(couponInput, couponCode);
        ele.click(couponApplyBtn);
        ele.waitForAjaxToComplete();
        ele.isElementDisplayed(alertDanger);
    }

    public void applyVoucher(String voucherCode) {
        ele.click(voucherAccordion);
        ele.type(voucherInput, voucherCode);
        ele.click(voucherApplyBtn);
        ele.waitForAjaxToComplete();
        ele.isElementDisplayed(alertDanger);
    }

    public void estimateShipping(String country, String zone, String postcode) {
        ele.click(shippingAccordion);
        ele.selectByVisibleText(shippingCountryDropdown, country);
        ele.waitForOptionPresent(shippingZoneDropdown, zone);
        ele.selectByVisibleText(shippingZoneDropdown, zone);
        ele.type(shippingPostcodeInput, postcode);
        ele.click(getQuotesBtn);
        ele.waitForAjaxToComplete();
    }

    public String getAlertText() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            WebElement alert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.cssSelector(".alert-danger, .alert-warning, .alert-success, .alert-dismissible, .alert")));
            String text = alert.getText();
            if (text == null || text.trim().isEmpty()) {
                text = (String) ((JavascriptExecutor) driver).executeScript("return arguments[0].innerText || arguments[0].textContent;", alert);
            }
            return text != null ? text.trim() : "";
        } catch (Exception e) {
            return ele.getTextSafely(By.cssSelector(".alert"));
        }
    }


    public boolean isCartEmpty() {
        return ele.isElementDisplayed(emptyCartMsg);
    }

    public void proceedToCheckout() {
        ele.click(checkoutBtn);
    }
}
