class HomeController < ApplicationController
  def index
    @clients = Client.all[1..-1]
  end
end
