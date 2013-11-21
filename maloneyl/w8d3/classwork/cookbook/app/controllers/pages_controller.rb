class PagesController < ApplicationController
  include HighVoltage::StaticPage # override our PagesController's nonexistent show method and just use HighVoltage::StaticPage's

end
