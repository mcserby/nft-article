import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.devtools.DevTools;
import org.openqa.selenium.devtools.HasDevTools;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class Application {

    public static void main(String[] args) throws IOException, InterruptedException {
        String driverLocation = args[0];
        String facebookExportHtmlLocation = args[1];
        String outputFolder = args[2];
        System.setProperty("webdriver.chrome.driver", driverLocation);
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--kiosk");
        WebDriver driver = new ChromeDriver(options);
        DevTools devTools = ((HasDevTools) driver).getDevTools();
        devTools.createSession();
        driver.get(facebookExportHtmlLocation);
        WebElement container = driver.findElement(By.className("_4t5n"));
        container.getLocation();
        int height = 0;
        int margin = 8;
        int width = 598;
        //((JavascriptExecutor) driver).executeScript("document.body.style.zoom = '80%';");
        List<WebElement> children = container.findElements(By.xpath("./child::*"));
        Point startPostPoint = null;
        int index = 0;
        for (WebElement e : children) {
            String name = String.format("%05d", index++) + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm_ss"));
            Point point = e.getLocation();
            if(startPostPoint == null){
                startPostPoint = point;
            }
            File screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
            BufferedImage fullImg = ImageIO.read(screenshot);

            int postHeight = e.getSize().getHeight();
            height += postHeight + margin;

            if(postHeight > fullImg.getHeight()){
                System.out.println("warning, image must be composed out of multiple parts");
                postHeight = fullImg.getHeight();
                name += "_part_1";
            }
            BufferedImage post = fullImg.getSubimage(startPostPoint.getX(), 0, width,
                    postHeight);
            File screenshotLocation = new File( outputFolder  + "/" + name + ".png");
            ImageIO.write(post, "png", screenshotLocation);
            ((JavascriptExecutor) driver).executeScript("window.scrollTo(0, " + height + ")");
            Thread.sleep(100);
        }
        driver.quit();
    }
}
