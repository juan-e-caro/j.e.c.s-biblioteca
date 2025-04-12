<!-- In your <head> tag -->
<script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
<style>
  #webchat .bpWebchat {
    position: unset;
    width: 100%;
    height: 100%;
    max-height: 100%;
    max-width: 100%;
  }

  #webchat .bpFab {
    display: none;
  }
</style>

<!-- Put this on your page BEFORE the script below -->
<div id="webchat" style="width: 500px; height: 500px;"></div>

<!-- In your <body> tag -->
<script>
  window.botpress.on("webchat:ready", () => {
    window.botpress.open();
  });
  window.botpress.init({
  "botId": "ed89b63d-5216-4cf6-8ff9-f46a0c34f00a",
  "configuration": {
    "website": {},
    "email": {},
    "phone": {},
    "termsOfService": {},
    "privacyPolicy": {},
    "color": "#3B82F6",
    "variant": "solid",
    "themeMode": "light",
    "fontFamily": "inter",
    "radius": 1
  },
  "clientId": "97dad5f9-adb9-4666-9b7f-898b5b8be8f9",
  "selector": "#webchat"
});
</script>