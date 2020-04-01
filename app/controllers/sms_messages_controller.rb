class SmsMessagesController < ApplicationController
    include Plivo
    skip_forgery_protection
    def create
        
        puts "you did it"
        puts params[:SMSNumber]
        puts params[:SMSText]

        plivo_src_number = "+14459995374"

        message = "sms text:"+params[:SMSText]+", to:"+params[:SMSNumber]
        destination_number = "+19196739974"
        subaccount_auth_id = Rails.application.credentials[:PLIVO][:AUTH_ID]
        subaccount_auth_token = Rails.application.credentials[:PLIVO][:AUTH_TOKEN]
        client = RestClient.new(subaccount_auth_id, subaccount_auth_token)
        message_created = client.messages.create(
        plivo_src_number,
        [destination_number],
        message
        )
        puts message_created
        render json: {message: "great job"}
    end

    def new
        auth_id = Rails.application.credentials[:PLIVO][:AUTH_ID]
        auth_token = Rails.application.credentials[:PLIVO][:AUTH_TOKEN]
        client = Phlo.new(auth_id, auth_token)
        phlo = client.phlo.get('72f4d92b-0a51-4d9a-94a8-1de12dbe036e')
        params[:to] = "+19196739974"
        params[:from] = "+14459995374"
        phlo.run(params)

    end

    def index
        subaccount_auth_id = Rails.application.credentials[:PLIVO][:AUTH_ID]
        subaccount_auth_token = Rails.application.credentials[:PLIVO][:AUTH_TOKEN]
        api = RestClient.new(subaccount_auth_id, subaccount_auth_token)
        response = api.messages.list(
            # message_direction: 'inbound',
            # subaccount: subaccount_auth_id
        )
        #   attempted to iterate on objects "array"
        
        return_array = []
        puts "starting new history query"
        puts '*****************************************'
        response[:objects].each do |resource|
            #  convert each to a string instead of a Plivo::Resources::Message
            
             return_array.push(resource.to_s)
        end
        # testing response object
        # puts "return array we build"
        # puts return_array
        # puts response
        # puts 'response  objects class'
        # puts response[:objects].class
        # puts 'objects 0 class'
        # puts response[:objects][0].class
        # puts response[:objects][0].acts_like?(Hash)
        # puts response[:objects][0].methods
        # puts response[:objects][0].class.ancestors
        # # puts response[:objects][0].to_json()

        # will need some checking to ensure all of history is grabbed
        # if response[:meta]["next"]==nil  
        # end
        
        
        render json: {response: return_array}
    end

    # def response
    #     from_number = params[:From]
    #     to_number = params[:To]
    #     text = params[:Text]
    #     puts "Message received - From: #{from_number}, To: #{to_number}, Text: #{text}"
      
    #     # send the details to generate an XML
    #     response = Response.new
    #     params = {
    #       src: to_number,
    #       dst: from_number,
    #     }
    #     message_body = "Thank you, we have received your request"
    #     response.addMessage(message_body, params)
    #     xml = PlivoXML.new(response)
    #     #   sinatra commands
    #     # content_type "application/xml"
    #     # return xml.to_s()

    #     render xml: xml
    # end

    # plivo snippet
    # get "/reply_to_sms/" do
    #     from_number = params[:From]
    #     to_number = params[:To]
    #     text = params[:Text]
    #     puts "Message received - From: #{from_number}, To: #{to_number}, Text: #{text}"
      
    #     # send the details to generate an XML
    #     response = Response.new
    #     params = {
    #       src: to_number,
    #       dst: from_number,
    #     }
    #     message_body = "Thank you, we have received your request"
    #     response.addMessage(message_body, params)
    #     xml = PlivoXML.new(response)
      
    #     content_type "application/xml"
    #     return xml.to_s()
    #   end


end
