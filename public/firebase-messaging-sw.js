self.addEventListener("push", (event) => {
  console.log("EVENTO:"+event.data);
  let title = "Bienvenido al Sistema de Información de Grupos de Investigación";
  let renotify= true;
  let body = (event.data && event.data.text()) || "Bienvenido al Sistema de Información de Grupos de Investigación";
  let tag = "Sigi";
  let icon = "assets/unal/escudoUnal_black-f03f4d2e4dacdd5c8569addb53eb0dfe581a30e296a71cdfd5865b00249df3ac.png";

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag,renotify })
  )
});
