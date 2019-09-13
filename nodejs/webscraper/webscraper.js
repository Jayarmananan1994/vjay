const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.goto(
    "https://www.google.com/search?q=intitle%3Aindex+of+mkv+triangle",
    { waitUntil: "networkidle2" }
  );
  //await page.goto("https://asahitechnologies.com/contact",{waitUntil: 'networkidle2'});
  //await page.screenshot({path: 'example2.png'});
  //const pageHeaders = await page.content()
  const results = await page.evaluate(() =>
    Array.from(document.querySelectorAll("div.r > a")).map(a => a.href)
  );

  let movieLinks = [];
  for (i = 0; i < results.length; i++) {
    if (movieLinks.length < 4) {
      console.log("Visiting url:" + results[i]);
      try {
        await page.goto(results[i], { waitUntil: "networkidle2" });
        let links = await page.evaluate(() =>
          Array.from(document.querySelectorAll("a[href*='triangle' i]","a[href*='.mkv']"), a => a.href)
        );
        let validLinks = links.filter(val => {
          return val.indexOf(".mkv") > 0 && val.toLowerCase().indexOf('triangle') > 0;
        });
        console.log("Links from page:" + links);
        movieLinks = movieLinks.concat(validLinks);
      } catch (e) {
        console.log("an expection on page.evaluate", e);
      }
    }
  }

  //   hrefs1.forEach((val, key) => {
  //     if (val.indexOf(".mkv") > 0) {
  //       movieLinks.push(val);
  //     }
  //   });

  console.log("Final movie list:"+movieLinks);
  await browser.close();
})();
