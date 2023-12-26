const playwright = require("playwright");
// const debug = require("debug");
// debug.log = console.info.bind(console); // binding console.info or console.log
const args = [
  "--autoplay-policy=user-gesture-required",
  "--disable-background-networking",
  "--disable-background-timer-throttling",
  "--disable-backgrounding-occluded-windows",
  "--disable-breakpad",
  "--disable-client-side-phishing-detection",
  "--disable-component-update",
  "--disable-default-apps",
  "--disable-dev-shm-usage",
  "--disable-domain-reliability",
  "--disable-extensions",
  "--disable-features=AudioServiceOutOfProcess",
  "--disable-hang-monitor",
  "--disable-ipc-flooding-protection",
  "--disable-notifications",
  "--disable-offer-store-unmasked-wallet-cards",
  "--disable-popup-blocking",
  "--disable-print-preview",
  "--disable-prompt-on-repost",
  "--disable-renderer-backgrounding",
  "--disable-setuid-sandbox",
  "--disable-speech-api",
  "--disable-sync",
  "--disk-cache-size=33554432",
  "--hide-scrollbars",
  "--ignore-gpu-blacklist",
  "--metrics-recording-only",
  "--mute-audio",
  "--no-default-browser-check",
  "--no-first-run",
  "--no-pings",
  "--no-sandbox",
  "--no-zygote",
  "--password-store=basic",
  "--use-gl=swiftshader",
  "--use-mock-keychain",
  "--single-process",
  "--no-sandbox",
  "--disable-setuid-sandbox",
  "-–disable-dev-shm-usage",
  "--disable-gpu",
  "--no-first-run",
  "--no-zygote",
  "--single-process",
];

exports.handler = async (event) => {
  const browser = await playwright.chromium.launch({
    headless: true,
    args,
  });
  const context = await browser.newContext();
  const page = await context.newPage();
  page.setDefaultNavigationTimeout(45000);
  // await page.goto("https://google.com");
  await page.goto("https://google.com", { waitUntil: "networkidle" });
  const title = await page.title();
  console.log("Title:", title);
  await browser.close();

  const response = {
    statusCode: 200,
    body: JSON.stringify(`Page title is: ${title}`),
  };

  return response;
};
