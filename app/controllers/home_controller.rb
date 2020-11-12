class HomeController < ApplicationController
  def index
    @file_uploads = current_user.file_uploads
  end
end
