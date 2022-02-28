class ElementsController < ApplicationController
  def index

  end
  def new
    @element = Element.new
  end
end
