require 'open-uri'

class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
    def index
        url = "https://savewhey-api.herokuapp.com/api/v1/suplementos?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        if params[:query].present?
            search =  params[:query].split(' ').join('+')
            url = url + "&query=#{search}"
        end
        if params[:page].present?
            url = url + "&page=#{params[:page]}"
        end
        if params[:changed].present?
            url = url + "&changed=#{params[:changed]}"
        end
        suple_serialized = open(url).read
        @headers = JSON.parse(suple_serialized, {:symbolize_names => true})[0]
        @suplementos = JSON.parse(suple_serialized, {:symbolize_names => true})[1..]
    end
end