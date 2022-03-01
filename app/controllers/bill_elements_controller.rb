class BillElementsController < ApplicationController
  def create
    @bill = Bill.find(params[:bill_id])
    @bill_element = BillElement.new(bill_element_params)
    @bill_element.bill = @bill
    @element = Element.find( params[:bill_element][:element_id])
    if @element.element_sales.empty?
      @bill_element.original_element = [@element.code, @element.price.to_f]
    else
      @bill_element.original_element = [@element.code, @element.price.to_f, @element.element_sales.last.quantity,@element.element_sales.last.sale_price.to_f]
    end
    if @bill_element.valid?
      @bill_element.save
      redirect_to bill_path(@bill)
    else
      redirect_to bill_path(@bill)
    end
  end
private
  def bill_element_params
    params.require(:bill_element).permit(:element_id)
  end
end
