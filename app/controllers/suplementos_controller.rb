require 'open-uri'
require 'json'

class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index get_bitlink]
    def index
        url = "https://savewhey-api.herokuapp.com/api/v1/suplementos?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        params.each { |key, value| url = url + "&#{key}=#{value}" unless ['controller', 'action', 'utf8'].include? key }
        suple_serialized = open(url).read
        @stores = get_stores()
        @headers = JSON.parse(suple_serialized, {:symbolize_names => true})[0]
        @suplementos = JSON.parse(suple_serialized, {:symbolize_names => true})[1..]
    end

    def get_bitlink
        client = Bitly.client
        @suplemento = params[:suplemento]
        if params[:choice].present?
            link = params[:suplemento][:link].gsub('lojacorpoperfeito',params[:choice])
            @shorten_url = Bitly.client.shorten(link).short_url
        else
            @shorten_url = Bitly.client.shorten(@suplemento[:link]).short_url
        end
    end

    def get_stores
        api_endpoint = "https://savewhey-api.herokuapp.com/api/v1/stores?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        stores_serialized = open(api_endpoint).read
        JSON.parse(stores_serialized, {:symbolize_names => true})[0]
    end

end