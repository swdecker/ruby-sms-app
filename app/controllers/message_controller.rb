class MessageController < ApplicationController

    def send 
        client = RestClient.new(Rails.application.credentials[:plivo][:auth_id], Rails.application.credentials[:plivo][:auth_token]);
    end
end
