// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

if ('serviceWorker' in navigator) {
    window.addEventListener('load', function() {
      navigator.serviceWorker.register('/service-worker.js')
        .then(function(registration) {
          console.log('Service Worker зарегистрирован с областью: ', registration.scope);
        })
        .catch(function(error) {
          console.log('Ошибка при регистрации Service Worker: ', error);
        });
    });
  }
  