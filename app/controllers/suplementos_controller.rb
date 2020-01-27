require 'open-uri'
require 'json'

class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index get_bitlink create_bitlink]
    def index   
        url = "https://savewhey-api.herokuapp.com/api/v1/suplementos?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"   
        pg_params = get_params()
        pg_params.each { |key, value| url = url + "&#{key}=#{value.kind_of?(Array) ? value[0] : value}" unless ['controller', 'action', 'utf8'].include? key }
        suple_serialized = open(url).read
        api_response = get_stores()
        @stores = api_response[:stores].map { |item| [item[:name], item[:id]] }
        @sellers = api_response[:sellers].map { |item| item[:seller] }
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

    def create_bitlink
        client = Bitly.client
        @suplemento = params[:suplemento]
        @link = params[:link]
        choice = params[:choice]&.first
        @link = change_cupom(@link, params[:cupom]) if params[:cupom].present?
        @link = @link.gsub('lojacorpoperfeito', choice) if choice.present?
        @link = Bitly.client.shorten(@link).short_url
    end

    def change_cupom(link, cupom)
        case link.match(/(?<=(www).)(.*)(?=\.com)/)[2] 
        when "lojacorpoperfeito"
            @link.gsub(/vp=.+/, "vp=#{cupom}")
        when "netshoes"
            @link.gsub(/(?<=(campaign).)(.*)(?=\])/, "#{cupom}")
        else
            @link
        end
    end

    def get_stores
        api_endpoint = "https://savewhey-api.herokuapp.com/api/v1/stores?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        stores_serialized = open(api_endpoint).read
        JSON.parse(stores_serialized, {:symbolize_names => true})
    end

    def parse_response(response, data)
        response[data].map { |item| [item[:name], item[:id]] }
    end

    private

    def get_params
      params.permit(:store, :name, { store:[] }, :page, :seller , :changed, :supershipping, :average, :promo)
    end

end