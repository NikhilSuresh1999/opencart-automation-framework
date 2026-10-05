package com.framework.Pages;

import com.framework.utils.ElementUtil;
import net.datafaker.Faker;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class CheckOutPage {
    private WebDriver driver;
    private ElementUtil ele;
    private Faker faker;

    // TutorialsNinja Checkout Steps
    private By guestCheckoutRadio = By.xpath("//input[@value='guest']");
    private By step1ContinueBtn = By.id("button-account");
    private By fNameInput = By.id("input-payment-firstname");
    private By lNameInput = By.id("input-payment-lastname");
    private By emailInput = By.id("input-payment-email");
    private By telephoneInput = By.id("input-payment-telephone"); // Required in TutorialsNinja
    private By addressInput = By.id("input-payment-address-1");
    private By cityInput = By.id("input-payment-city");
    private By postcodeInput = By.id("input-payment-postcode");
    private By countryDropdown = By.id("input-payment-country");
    private By zoneDropdown = By.id("input-payment-zone");
    private By step2ContinueBtn = By.id("button-guest");
    private By flatRateRadio = By.xpath("//input[contains(@value, 'flat')]");
    private By step4ContinueBtn = By.id("button-shipping-method");
    private By termsCheckbox = By.name("agree");
    private By step5ContinueBtn = By.id("button-payment-method");
    private By confirmOrderBtn = By.id("button-confirm");
    private By successMessage = By.xpath("//h1[text()='Your order has been placed!']");

    public CheckOutPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
        this.faker = new Faker();
    }

    public void selectCheckoutType(String type) {
        ele.waitForAjaxToComplete();
        if (type.equalsIgnoreCase("Guest")) {
            ele.click(guestCheckoutRadio);
        }
        ele.click(step1ContinueBtn); // Move to Step 2
    }

    public void enterBillingDetails(String country, String zone) {
        ele.waitForAjaxToComplete();
        ele.type(fNameInput, faker.name().firstName());
        ele.type(lNameInput, faker.name().lastName());
        ele.type(emailInput, faker.internet().emailAddress());
        
        // Added required phone field for TutorialsNinja
        ele.type(telephoneInput, faker.phoneNumber().subscriberNumber(10));
        
        ele.type(addressInput, faker.address().streetAddress());
        ele.type(cityInput, faker.address().city());
        ele.type(postcodeInput, faker.address().zipCode());
        
        ele.selectByVisibleText(countryDropdown, country);
        ele.waitForAjaxToComplete(); 
        ele.selectByVisibleText(zoneDropdown, zone);
        
        ele.click(step2ContinueBtn);
    }

    public void selectShippingMethod(String method) {
        ele.waitForAjaxToComplete();
        if (method.contains("Flat")) {
            ele.click(flatRateRadio);
        }
        ele.click(step4ContinueBtn);
    }

    public void confirmOrderAndPayment() {
        ele.waitForAjaxToComplete();
        ele.clickWithJS(termsCheckbox);
        ele.click(step5ContinueBtn);
        
        ele.waitForAjaxToComplete();
        ele.click(confirmOrderBtn);
    }

    public String getOrderStatus() {
        ele.waitForAjaxToComplete();
        return ele.getTextSafely(successMessage).equals("Your order has been placed!") ? "Order Placed" : "Address Error";
    }
}