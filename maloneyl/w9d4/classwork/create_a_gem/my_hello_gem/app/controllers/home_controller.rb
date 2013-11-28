class HomeController < ApplicationController
  def index
    @hello = HelloWorld.random
  end
end
