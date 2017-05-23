self.addEventListener("push", (event) => {
  console.log("EVENTO:"+event.data);
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "Bienvenido al Sistema de Información de Tesis de Grupos de Investigación";
  let tag = "push-simple-demo-notification-tag";
  let icon = "<%= image_url('unal/escudoUnal')%>";

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});
