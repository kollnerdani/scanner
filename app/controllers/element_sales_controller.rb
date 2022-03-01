class ElementSalesController < ApplicationController
before_action :find_element_sale, only:[:update]
def update
  if @element_sale.update(element_sale_params)
    redirect_to elements_path
  else
    redirect_to elements_path
  end
end
private
  def element_sale_params
    params.require(:element_sale).permit(:quantity, :sale_price)
  end
  def find_element_sale
    @element_sale = ElementSale.find(params[:id])
  end
end
