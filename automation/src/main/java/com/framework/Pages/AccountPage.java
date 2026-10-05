package com.framework.Pages;

import com.framework.utils.ElementUtil;
import net.datafaker.Faker;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class AccountPage {
    private WebDriver driver;
    private ElementUtil ele;
    private Faker faker;

    // Registration Locators
    private By myAccountDropdown = By.xpath("//a[@title='My Account']");
    private By registerLink = By.xpath("//a[normalize-space()='Register']");
    private By loginLink = By.xpath("//a[normalize-space()='Login']");
    private By logoutLink = By.xpath("//a[normalize-space()='Logout']");
    
    private By fNameInput = By.id("input-firstname");
    private By lNameInput = By.id("input-lastname");
    private By emailInput = By.id("input-email");
    private By telephoneInput = By.id("input-telephone");
    private By passwordInput = By.id("input-password");
    private By confirmPasswordInput = By.id("input-confirm");
    private By privacyPolicyCheckbox = By.name("agree");
    private By registerContinueBtn = By.xpath("//input[@value='Continue']");
    private By registerSuccessHeading = By.xpath("//h1[text()='Your Account Has Been Created!']");
    
    // Login Locators
    private By loginEmailInput = By.id("input-email");
    private By loginPasswordInput = By.id("input-password");
    private By loginSubmitBtn = By.xpath("//input[@value='Login']");
    private By forgottenPasswordLink = By.xpath("//div[@class='form-group']//a[contains(text(), 'Forgotten Password')]");
    private By forgottenEmailInput = By.id("input-email");
    private By forgottenContinueBtn = By.xpath("//input[@value='Continue']");
    private By alertSuccess = By.cssSelector(".alert-success");
    private By alertDanger = By.cssSelector(".alert-danger");
    private By textDanger = By.cssSelector(".text-danger");
    private By accountDashboardHeading = By.xpath("//h2[text()='My Account']");
    private By logoutSuccessHeading = By.xpath("//h1[text()='Account Logout']");

    public AccountPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
        this.faker = new Faker();
    }

    public void navigateToRegister() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=account/register");
    }

    public void navigateToLogin() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=account/login");
    }

    public void registerUserComprehensive(String fName, String lName, String email, String phone, String pass, String confirmPass, boolean agreePolicy) {
        navigateToRegister();
        ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
            "var forms = document.getElementsByTagName('form'); for(var i=0; i<forms.length; i++) { forms[i].setAttribute('novalidate', 'novalidate'); }"
        );
        ele.type(fNameInput, fName.equals("Dynamic") ? faker.name().firstName() : fName);
        ele.type(lNameInput, fName.equals("Dynamic") ? faker.name().lastName() : lName);
        ele.type(emailInput, email.equals("dynamic") ? faker.internet().emailAddress() : email);
        ele.type(telephoneInput, phone.equals("dynamic") ? faker.phoneNumber().subscriberNumber(10) : phone);
        ele.type(passwordInput, pass);
        ele.type(confirmPasswordInput, confirmPass);

        if (agreePolicy) {
            ele.clickWithJS(privacyPolicyCheckbox);
        }
        ele.click(registerContinueBtn);
        ele.waitForAjaxToComplete();

        if (email.contains("existing") && ele.isElementDisplayed(registerSuccessHeading)) {
            logout();
            navigateToRegister();
            ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                "var forms = document.getElementsByTagName('form'); for(var i=0; i<forms.length; i++) { forms[i].setAttribute('novalidate', 'novalidate'); }"
            );
            ele.type(fNameInput, "Robert");
            ele.type(lNameInput, "Smith");
            ele.type(emailInput, email);
            ele.type(telephoneInput, "9876543210");
            ele.type(passwordInput, pass);
            ele.type(confirmPasswordInput, confirmPass);
            ele.clickWithJS(privacyPolicyCheckbox);
            ele.click(registerContinueBtn);
            ele.waitForAjaxToComplete();
        }
    }

    public void login(String email, String password) {
        navigateToLogin();
        ele.type(loginEmailInput, email);
        ele.type(loginPasswordInput, password);
        ele.click(loginSubmitBtn);
        ele.waitForAjaxToComplete();
    }

    public void logout() {
        ele.click(myAccountDropdown);
        ele.click(logoutLink);
        ele.waitForAjaxToComplete();
    }

    public void requestPasswordReset(String email) {
        navigateToLogin();
        ele.click(forgottenPasswordLink);
        ele.type(forgottenEmailInput, email);
        ele.click(forgottenContinueBtn);
        ele.waitForAjaxToComplete();
    }

    public String getRegistrationStatus() {
        if (ele.isElementDisplayed(registerSuccessHeading)) {
            return "Account Created";
        }
        StringBuilder sb = new StringBuilder();
        if (ele.isElementDisplayed(alertDanger)) {
            sb.append(ele.getTextSafely(alertDanger).trim()).append(" ");
        }
        for (org.openqa.selenium.WebElement el : driver.findElements(textDanger)) {
            try {
                if (el.isDisplayed()) {
                    sb.append(el.getText().trim()).append(" ");
                }
            } catch (Exception ignored) {}
        }
        String errors = sb.toString().trim();
        return errors.isEmpty() ? "Unknown Error" : errors;
    }

    public String getLoginStatus() {
        if (ele.isElementDisplayed(accountDashboardHeading)) {
            return "Login Successful";
        }
        if (ele.isElementDisplayed(alertDanger)) {
            return ele.getTextSafely(alertDanger).trim();
        }
        return "Unknown State";
    }

    public boolean isLogoutSuccessful() {
        return ele.isElementDisplayed(logoutSuccessHeading);
    }

    public boolean isPasswordResetConfirmationDisplayed() {
        return ele.isElementDisplayed(alertSuccess) || ele.isElementDisplayed(alertDanger);
    }
}

