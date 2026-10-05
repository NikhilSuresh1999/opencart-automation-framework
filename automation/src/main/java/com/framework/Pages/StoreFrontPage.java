package com.framework.Pages;

import com.framework.utils.ElementUtil;
import net.datafaker.Faker;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class StoreFrontPage {
    private WebDriver driver;
    private ElementUtil ele;
    private Faker faker;

    // TutorialsNinja OpenCart 2.x Registration Locators
    private By myAccountMenu = By.xpath("//a[@title='My Account']");
    private By registerLink = By.xpath("//a[normalize-space()='Register']");
    private By fNameInput = By.name("firstname");
    private By lNameInput = By.name("lastname");
    private By emailInput = By.name("email");
    private By phoneInput = By.name("telephone"); // Required in TutorialsNinja
    private By passInput = By.name("password");
    private By passConfirmInput = By.name("confirm"); // Required in TutorialsNinja
    private By agreeCheckbox = By.name("agree");
    private By continueBtn = By.xpath("//input[@value='Continue']");
    private By successMsg = By.xpath("//h1[text()='Your Account Has Been Created!']");
    private By errorWarning = By.cssSelector("div.text-danger, div.alert-danger");
    private By successAlert = By.cssSelector("div.alert-success");

    // Search & Grid Locators
    private By searchBox = By.name("search");
    private By searchBtn = By.xpath("//button[contains(@class, 'btn-default')]");
    private By productTitles = By.cssSelector("div.product-layout h4 a");
    private By emptySearchMsg = By.xpath("//p[contains(text(), 'There is no product')]");

    // Cart Locators
    private By addToCartBtn = By.xpath("(//button[contains(@onclick, 'cart.add')])[1]");
    private By cartTotalBtn = By.id("cart-total");

    public StoreFrontPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
        this.faker = new Faker();
    }

    public void registerUser(String fName, String lName, String email, String pass) {
        ele.click(myAccountMenu);
        ele.click(registerLink);
        
        ele.type(fNameInput, fName.equals("Dynamic") ? faker.name().firstName() : fName);
        ele.type(lNameInput, lName.equals("User") ? faker.name().lastName() : lName);
        ele.type(emailInput, email.equals("dynamic") ? faker.internet().emailAddress() : email);
        
        // Added required phone and confirm password fields for TutorialsNinja
        ele.type(phoneInput, faker.phoneNumber().subscriberNumber(10));
        ele.type(passInput, pass);
        ele.type(passConfirmInput, pass);
        
        ele.clickWithJS(agreeCheckbox);
        ele.click(continueBtn);
        ele.waitForAjaxToComplete();
    }

    public String getRegistrationStatus() {
        if (ele.isElementDisplayed(successMsg)) return "Account Created";
        if (ele.isElementDisplayed(errorWarning)) return ele.getTextSafely(errorWarning);
        return "Unknown Error";
    }

    public void searchProduct(String keyword) {
        ele.type(searchBox, keyword);
        ele.click(searchBtn);
    }

    public String getGridResult() {
        if (ele.isElementDisplayed(emptySearchMsg)) return "No product matches";
        return ele.getTextSafely(productTitles);
    }

   public void addToCartDynamic(String product, String qty) {
        searchProduct(product);
        ele.click(addToCartBtn);
        
        // Wait for the green success banner to ensure the item is in the cart
        ele.isElementDisplayed(successAlert);
        
        // Give the OpenCart server 1.5 seconds to save the session cookie
        try {
            Thread.sleep(1500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public String getCartBadge() {
        return ele.getTextSafely(cartTotalBtn);
    }
}