class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cartao
  end

  def tag_info
  end

  def tag
    @tags = Tag.where(user: current_user)
    if @tags.empty?
      redirect_to tag_info_path
    else
      redirect_to tags_path
    end
  end
end
