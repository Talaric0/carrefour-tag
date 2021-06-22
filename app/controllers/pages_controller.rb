class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cartao
    
  end

  def tag
    @tags = Tag.where(user: current_user)
  end
  
end
