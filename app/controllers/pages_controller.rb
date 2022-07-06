class PagesController < ApplicationController
  def
    @users_table = User.order(:id, :first_name, :last_name, :role)
  end
end