class MicropostsController < ApplicationController
  before_action :signed_in_user, only: %i[create destroy]

  def index; end

  def create; end

  def destroy; end
end
