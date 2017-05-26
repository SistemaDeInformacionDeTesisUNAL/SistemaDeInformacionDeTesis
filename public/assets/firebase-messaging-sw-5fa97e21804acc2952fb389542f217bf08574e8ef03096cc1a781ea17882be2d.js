self.addEventListener("push", (event) => {
  console.log("EVENTO:"+event.data);
  let title = "Sigi";
  let body = (event.data && event.data.text()) || "Bienvenido al Sistema de Información de Tesis de Grupos de Investigación";
  let tag = "sigi";
  let icon = "escudoUnal_black.png";

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});
