class HomeController < ApplicationController
  def index
    if current_user
      redirect_to printing_sets_path
    end
  end

  def subscribe
    puts "subscribe"
    redirect_to root_url
  end

  def unsubscribe
    puts "unsubscribe"
    redirect_to root_url
  end
end
