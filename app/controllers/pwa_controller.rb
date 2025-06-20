class PwaController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def manifest
      render file: Rails.root.join('app/views/pwa/manifest.json.erb'), content_type: 'application/json'
    end
  
    def service_worker
      render file: Rails.root.join('app/views/pwa/service-worker.js'), content_type: 'application/javascript'
    end
  
    def offline
      render 'offline', layout: false
    end
  end