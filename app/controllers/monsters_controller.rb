class MonstersController < ApplicationController
  def index
    @monsters = Monster.all
  end
end
