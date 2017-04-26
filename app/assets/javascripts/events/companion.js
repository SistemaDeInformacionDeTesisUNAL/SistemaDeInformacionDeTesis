  if (navigator.serviceWorker) {
    console.log('Registering serviceworker');
    navigator.serviceWorker.register('/events/serviceworker.js')
      .then(function(reg) {
        console.log('Successfully registered!', ':^)', reg);
        reg.pushManager.subscribe({ userVisibleOnly: true })
        .then(function(subscription) {
            $.post("/subscribe", { subscription: subscription.toJSON() });
        });
        
  }).catch(function(error) {
    console.log('Registration failed', ':^(', error);
  });
}
