class IndexController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @settings = Settings.with_defaults
  end

end