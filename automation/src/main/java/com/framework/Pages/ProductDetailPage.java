package com.framework.Pages;

import com.framework.utils.ElementUtil;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;

public class ProductDetailPage {

    private WebDriver driver;
    private ElementUtil ele;

    private By productTitle = By.xpath("//div[@id='content']//h1");
    private By descriptionTab = By.xpath("//a[normalize-space()='Description']");
    private By descriptionContent = By.id("tab-description");
    private By specificationTab = By.xpath("//a[contains(normalize-space(),'Specification')]");
    private By specificationContent = By.id("tab-specification");
    private By reviewsTab = By.xpath("//a[contains(normalize-space(),'Reviews')]");
    
    // Reviews Form
    private By reviewAuthorInput = By.id("input-name");
    private By reviewTextInput = By.id("input-review");
    private By submitReviewBtn = By.id("button-review");
    private By reviewAlert = By.cssSelector("#tab-review .alert, #form-review .alert, .alert-dismissible");

    // Product actions
    private By quantityInput = By.id("input-quantity");
    private By addToCartBtn = By.id("button-cart");
    private By addToWishListBtn = By.xpath("//button[@data-original-title='Add to Wish List']");
    private By compareProductBtn = By.xpath("//button[@data-original-title='Compare this Product']");
    private By alertSuccess = By.cssSelector(".alert-success");

    public ProductDetailPage(WebDriver driver) {
        this.driver = driver;
        this.ele = new ElementUtil(driver);
    }

    public void navigateToProduct(int productId) {
        driver.get("https://tutorialsninja.com/demo/index.php?route=product/product&product_id=" + productId);
        ele.waitForAjaxToComplete();
    }

    public String getProductTitle() {
        return ele.getTextSafely(productTitle);
    }

    public void clickDescriptionTab() {
        ele.click(descriptionTab);
    }

    public boolean isDescriptionDisplayed() {
        return ele.isElementDisplayed(descriptionContent);
    }

    public void clickSpecificationTab() {
        ele.click(specificationTab);
    }

    public boolean isSpecificationDisplayed() {
        return ele.isElementDisplayed(specificationContent);
    }

    public void clickReviewsTab() {
        ele.click(reviewsTab);
    }

    public void submitReview(String author, String reviewText, int rating) {
        clickReviewsTab();
        ele.type(reviewAuthorInput, author);
        ele.type(reviewTextInput, reviewText);
        if (rating >= 1 && rating <= 5) {
            ele.click(By.xpath("//input[@name='rating' and @value='" + rating + "']"));
        }
        ele.click(submitReviewBtn);
        ele.waitForAjaxToComplete();
        ele.isElementDisplayed(reviewAlert);
    }

    public String getReviewAlertText() {
        try {
            WebDriverWait dynamicWait = new WebDriverWait(driver, Duration.ofSeconds(15));
            WebElement alert = dynamicWait.until(ExpectedConditions.visibilityOfElementLocated(reviewAlert));
            String text = alert.getText();
            if (text == null || text.trim().isEmpty()) {
                text = (String) ((JavascriptExecutor) driver).executeScript("return arguments[0].innerText || arguments[0].textContent;", alert);
            }
            return text != null ? text.trim() : "";
        } catch (Exception e) {
            return ele.getTextSafely(reviewAlert);
        }
    }

    public void setQuantity(String qty) {
        try {
            WebElement el = driver.findElement(quantityInput);
            ((JavascriptExecutor) driver).executeScript("arguments[0].value = arguments[1]; $(arguments[0]).trigger('change');", el, qty);
        } catch (Exception e) {
            ele.type(quantityInput, qty);
        }
    }

    public void addToCart() {
        ele.scrollToElement(addToCartBtn);
        ele.click(addToCartBtn);
        ele.isElementDisplayed(alertSuccess);
    }


    public void addToWishList() {
        ele.click(addToWishListBtn);
        ele.isElementDisplayed(alertSuccess);
    }

    public void addToCompare() {
        ele.click(compareProductBtn);
        ele.isElementDisplayed(alertSuccess);
    }

    public String getSuccessAlertText() {
        try {
            WebDriverWait dynamicWait = new WebDriverWait(driver, Duration.ofSeconds(15));
            WebElement alert = dynamicWait.until(ExpectedConditions.visibilityOfElementLocated(
                By.cssSelector(".alert-success, .alert-info, .alert-dismissible, .alert")));
            String text = alert.getText();
            if (text == null || text.trim().isEmpty()) {
                text = (String) ((JavascriptExecutor) driver).executeScript("return arguments[0].innerText || arguments[0].textContent;", alert);
            }
            return text != null ? text.trim() : "";
        } catch (Exception e) {
            return ele.getTextSafely(By.cssSelector(".alert, .alert-dismissible"));
        }
    }
}

