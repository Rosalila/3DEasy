class HomeController < ApplicationController
  def index
    if current_user
      redirect_to printing_sets_path
    end
    @printing_sets = get_featured_items
  end

  def subscribe
    @printing_sets = get_featured_items
  end
end
