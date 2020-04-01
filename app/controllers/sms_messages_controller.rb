class SmsMessagesController < ApplicationController
    include Plivo
    skip_forgery_protection
    def create
        
        puts "you did it"
        puts params[:SMSNumber]
        puts params[:SMSText]
        plivo_src_number = "+15123573063"
        message = "sms text:"+params[:SMSText]+", to:"+params[:SMSNumber]
        destination_number = "+19196739974"
        subaccount_auth_id = Rails.application.credentials[:PLIVO][:SUBACCOUNT_AUTH_ID]
        subaccount_auth_token = Rails.application.credentials[:PLIVO][:SUBACCOUNT_AUTH_TOKEN]
        
        client = RestClient.new(subaccount_auth_id, subaccount_auth_token)
        message_created = client.messages.create(
        plivo_src_number,
        [destination_number],
        message
        )
        puts message_created
        render json: {message: "great job"}
    end
    def index
        subaccount_auth_id = Rails.application.credentials[:PLIVO][:SUBACCOUNT_AUTH_ID]
        subaccount_auth_token = Rails.application.credentials[:PLIVO][:SUBACCOUNT_AUTH_TOKEN]
        api = RestClient.new(subaccount_auth_id, subaccount_auth_token)
        response = api.messages.list(
            # message_direction: 'inbound',
            subaccount: subaccount_auth_id
        )
        #   attempted to iterate on objects "array"
        
        return_array = []
        puts "starting new history query"
        puts '*****************************************'
        response[:objects].each do |resource|
            #  convert each to a string instead of a Plivo::Resources::Message
            
             return_array.push(resource.to_s)
        end
        puts "return array we build"
        puts return_array

        # will need some checking to ensure all of history is grabbed
        # if response[:meta]["next"]==nil  
        # end
        
        
        render json: {response: return_array}
    end
end
