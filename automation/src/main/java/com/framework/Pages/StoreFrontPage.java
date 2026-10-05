package com.framework.Pages;

import com.framework.utils.ElementUtil;
import net.datafaker.Faker;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;

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
    private By phoneInput = By.name("telephone");
    private By passInput = By.name("password");
    private By passConfirmInput = By.name("confirm");
    private By agreeCheckbox = By.name("agree");
    private By continueBtn = By.xpath("//input[@value='Continue']");
    private By successMsg = By.xpath("//h1[text()='Your Account Has Been Created!']");
    private By errorWarning = By.cssSelector("div.text-danger, div.alert-danger");
    private By successAlert = By.cssSelector("div.alert-success");

    // Search & Grid Locators
    private By searchBox = By.name("search");
    private By searchBtn = By.cssSelector("#search button");
    private By productTitles = By.cssSelector("div.product-layout h4 a");
    private By emptySearchMsg = By.xpath("//p[contains(text(), 'There is no product')]");
    
    // Advanced Search Locators
    private By advSearchInput = By.id("input-search");
    private By advCategorySelect = By.name("category_id");
    private By advSubCategoryCheckbox = By.name("sub_category");
    private By advDescriptionCheckbox = By.name("description");
    private By advSearchBtn = By.id("button-search");

    // Catalog controls
    private By sortDropdown = By.id("input-sort");
    private By limitDropdown = By.id("input-limit");
    private By listViewBtn = By.id("list-view");
    private By gridViewBtn = By.id("grid-view");
    private By categoryHeading = By.xpath("//div[@id='content']//h2");

    // Currency Switcher Locators
    private By currencyDropdownBtn = By.xpath("//form[@id='form-currency']//button[contains(@class,'dropdown-toggle')]");
    private By currencySymbolText = By.xpath("//form[@id='form-currency']//strong");
    
    // Cart Locators
    private By addToCartBtn = By.xpath("(//button[contains(@onclick, 'cart.add')])[1]");
    private By productAddToCartBtn = By.id("button-cart");
    private By cartTotalBtn = By.id("cart-total");

    public StoreFrontPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
        this.faker = new Faker();
    }

    public void navigateToHome() {
        driver.get("https://tutorialsninja.com/demo/");
        ele.waitForAjaxToComplete();
    }

    public void registerUser(String fName, String lName, String email, String pass) {
        ele.click(myAccountMenu);
        ele.click(registerLink);
        
        ele.type(fNameInput, fName.equals("Dynamic") ? faker.name().firstName() : fName);
        ele.type(lNameInput, lName.equals("User") ? faker.name().lastName() : lName);
        ele.type(emailInput, email.equals("dynamic") ? faker.internet().emailAddress() : email);
        
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
        ele.waitForAjaxToComplete();
    }

    public String getGridResult() {
        if (ele.isElementDisplayed(emptySearchMsg)) return "No product matches";
        return ele.getTextSafely(productTitles);
    }

    public void navigateToSearchPage() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=product/search");
        ele.waitForAjaxToComplete();
    }

    public void performAdvancedSearch(String keyword, String category, boolean searchSubcat, boolean searchDesc) {
        navigateToSearchPage();
        ele.type(advSearchInput, keyword);
        if (category != null && !category.isEmpty()) {
            ele.selectByVisibleText(advCategorySelect, category);
        }
        if (searchSubcat) {
            ele.clickWithJS(advSubCategoryCheckbox);
        }
        if (searchDesc) {
            ele.clickWithJS(advDescriptionCheckbox);
        }
        ele.click(advSearchBtn);
        ele.waitForAjaxToComplete();
    }

    public void navigateToCategory(String path) {
        driver.get("https://tutorialsninja.com/demo/index.php?route=product/category&path=" + path);
        ele.waitForAjaxToComplete();
    }

    public String getCategoryHeading() {
        return ele.getTextSafely(categoryHeading);
    }

    public void selectSort(String sortOption) {
        ele.selectByVisibleText(sortDropdown, sortOption);
        ele.waitForAjaxToComplete();
    }

    public void selectLimit(String limitOption) {
        ele.selectByVisibleText(limitDropdown, limitOption);
        ele.waitForAjaxToComplete();
    }

    public void selectView(String view) {
        if (view.equalsIgnoreCase("list")) {
            ele.click(listViewBtn);
        } else {
            ele.click(gridViewBtn);
        }
        ele.waitForAjaxToComplete();
    }

    public void switchCurrency(String currencyCode) {
        ele.click(currencyDropdownBtn);
        By currBtn = By.name(currencyCode.toUpperCase());
        ele.click(currBtn);
        ele.waitForAjaxToComplete();
    }

    public String getCurrentCurrencySymbol() {
        return ele.getTextSafely(currencySymbolText);
    }

    public void addInStockProductToCart() {
        driver.get("https://tutorialsninja.com/demo/index.php?route=product/product&product_id=47");
        ele.scrollToElement(productAddToCartBtn);
        ele.click(productAddToCartBtn);
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(d -> {
                String txt = d.findElement(cartTotalBtn).getText();
                return txt != null && txt.contains("item(s)") && !txt.startsWith("0 item(s)");
            });
        } catch (Exception e) {
            // Proceed
        }
    }

    public void addToCartDynamic(String product, String qty) {
        if (product.equalsIgnoreCase("HP LP3065") || product.equalsIgnoreCase("in-stock")) {
            addInStockProductToCart();
            return;
        }
        searchProduct(product);
        ele.click(addToCartBtn);
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(d -> {
                String txt = d.findElement(cartTotalBtn).getText();
                return txt != null && txt.contains("item(s)") && !txt.startsWith("0 item(s)");
            });
        } catch (Exception e) {
            // Proceed
        }
    }


    public String getCartBadge() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            wait.until(d -> {
                String txt = d.findElement(cartTotalBtn).getText();
                return txt != null && txt.contains("item(s)");
            });
        } catch (Exception e) {
            // Proceed
        }
        return ele.getTextSafely(cartTotalBtn);
    }
}