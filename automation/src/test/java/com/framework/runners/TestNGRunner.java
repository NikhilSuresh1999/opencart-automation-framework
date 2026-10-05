package com.framework.runners;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.DataProvider;

  @CucumberOptions(
    features = "src/test/resources/features/OpenCartRegression.feature",
    glue = {"com.framework.steps", "com.framework.hooks"},
    plugin = {
            "pretty", 
            "html:target/cucumber-reports.html",
            "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"
    },
    monochrome = true
)
public class TestNGRunner extends AbstractTestNGCucumberTests {
    @Override
    // @DataProvider(parallel = true)
    @DataProvider(parallel = false)
    public Object[][] scenarios() {
        return super.scenarios();
    }
  
}
