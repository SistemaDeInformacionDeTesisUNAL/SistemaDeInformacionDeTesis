self.addEventListener("push", (event) => {
  console.log("EVENTO:"+event.data);
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "We hav -------!!!!-1";
  let tag = "push-simple-demo-notification-tag";
  let icon = '/unal/escudoUnal.png';

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});
