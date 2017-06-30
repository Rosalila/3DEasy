class HomeController < ApplicationController
  def index
    if current_user
      redirect_to printing_sets_path
    end
  end
end
