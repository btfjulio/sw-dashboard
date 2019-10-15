require 'open-uri'

class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
    def index
        url = "https://savewhey-api.herokuapp.com/api/v1/stores/1/suplementos?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy"
        if params[:query].present?
            search =  params[:query].split(' ').join('+')
            url = url + "&query=#{search}&commit=Search"
        end
        suple_serialized = open(url).read
        @suplementos = JSON.parse(suple_serialized, {:symbolize_names => true})
    end
end