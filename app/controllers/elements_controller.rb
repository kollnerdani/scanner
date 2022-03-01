class ElementsController < ApplicationController
  before_action :find_element, only:[:edit, :update]
  def index
    @elements = Element.order(:code)
    @element_sales = ElementSale.all
  end
  def new
    @element = Element.new
    @codes = ("A".."Z").to_a - Element.all.map{|el| el.code}
  end
  def create
    @element = Element.new(element_params)
    if @element.valid?
      if @element.sale
        @element.element_sales.build
      end
      @element.save
      redirect_to elements_path
    else
    end
  end
  def edit
    @codes = ("A".."Z").to_a - Element.select{|e| e.id != @element.id}.map{|el| el.code}
  end
  def update
    if @element.update(element_params)
      redirect_to elements_path
    else
      render :edit
    end
  end
private
  def find_element
    @element = Element.find(params[:id])
  end
  def element_params
    params.require(:element).permit(:code,:price, :sale )
  end
end
