require 'open-uri'

class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index get_bitlink]
    def index
        url = "https://savewhey-api.herokuapp.com/api/v1/suplementos?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        if params[:average].present?
            search =  params[:average].split(' ').join('+')
            url = url + "&average=#{search}"
        end
        if params[:seller].present?
            search =  params[:seller].split(' ').join('+')
            url = url + "&seller=#{search}"
        end
        if params[:name].present?
            search =  params[:name].split(' ').join('+')
            url = url + "&name=#{search}"
        end
        if params[:store].present?
            search =  params[:store].split(' ').join('+')
            url = url + "&store=#{search}"
        end
        if params[:page].present?
            url = url + "&page=#{params[:page]}"
        end
        url = url + "&changed=#{params[:changed]}" if params[:changed].present?
        url = url + "&supershipping=#{params[:supershipping]}" if params[:supershipping].present?
        suple_serialized = open(url).read
        @headers = JSON.parse(suple_serialized, {:symbolize_names => true})[0]
        @suplementos = JSON.parse(suple_serialized, {:symbolize_names => true})[1..]
    end

    def get_bitlink
        @suplemento = params[:suplemento]
        client = Bitly.client
        @shorten_url = Bitly.client.shorten(@suplemento[:link]).short_url
    end

end