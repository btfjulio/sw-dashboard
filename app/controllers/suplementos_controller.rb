
class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
  
    def index
        @suplementos = Suplemento.all.page(params[:page]).per(50)
    end
end