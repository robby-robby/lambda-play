const playwright = require('playwright');

exports.handler = async (event) => {
  const browser = await playwright.chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto('https://google.com');
  const title = await page.title();
  console.log("Title:", title);
  await browser.close();

  const response = {
    statusCode: 200,
    body: JSON.stringify(`Page title is: ${title}`),
  };
  
  return response;
};

