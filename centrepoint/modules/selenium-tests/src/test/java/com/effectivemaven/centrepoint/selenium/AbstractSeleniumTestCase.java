package com.effectivemaven.centrepoint.selenium;

/**
 * Copyright 2009
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */

import org.json.simple.JSONObject;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Optional;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.Selenium;

@Test( groups = "selenium" )
public abstract class AbstractSeleniumTestCase
{
    protected static Selenium selenium;

    @BeforeMethod
    @Parameters( { "selenium.username", "selenium.access-key", "selenium.os", "selenium.browser",
        "selenium.browser-version", "selenium.url" } )
    public void seleniumStart( String username, String accessKey, String os, String browser, String browserVersion,
                               String url, java.lang.reflect.Method m )
    {
        JSONObject config = new JSONObject();
        config.put( "username", username );
        config.put( "access-key", accessKey );
        config.put( "os", os );
        config.put( "browser", browser );
        config.put( "name", m.getName() );

        if ( browserVersion != null )
        {
            config.put( "browser-version", browserVersion );
        }

        selenium = new DefaultSelenium( "ondemand.saucelabs.com", 80, config.toJSONString(), url );
        selenium.start();
        selenium.setSpeed("3000");
    }

    @AfterMethod
    public void seleniumStop()
    {
        selenium.stop();
    }
}
