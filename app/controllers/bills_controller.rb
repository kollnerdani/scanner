class BillsController < ApplicationController
  before_action :find_bill, only:[:show,:update]
  def index
    @bills = Bill.all
  end
  def show
    @bill_element = BillElement.new
    total
  end
  def new
    @bill = Bill.new
  end
  def create
    @bill = Bill.new(bill_params)
    if @bill.valid?
      @bill.save
      redirect_to bill_path(@bill)
    else
      render :new
    end
  end
  def update
    total
    @bill.total = [@normal.to_i, @total_sale.to_i, @total]
    if @bill.update(bill_params)
      redirect_to bills_path
    else
      redirect_to bill_path(@bill)
    end
  end
private
  def total
    @normal = @bill.bill_elements.map{|be| be.element.price}.sum
    @element = []
    @bill.bill_elements.each do |bill|
      @element.push(bill.element.id)
    end
    @sale = {}
    @element.group_by(&:itself).each do |key, value|
      amount = value.count
      if !Element.find(key).element_sales.empty?
        sale = (amount/Element.find(key).element_sales.last.quantity) * Element.find(key).element_sales.last.sale_price
        rest = (amount%Element.find(key).element_sales.last.quantity) * Element.find(key).price
      else
        sale = 0
        rest = amount * Element.find(key).price
      end
      @sale[key] = [Element.find(key).code, Element.find(key).element_sales.empty?, amount, sale.to_i + rest.to_i]
    end
    @total_sale ||= @normal - @sale.map{|key, value| value[3]}.sum
    if @total != nil
      @total ||= @sale.map{|key, value| value[3]}.sum
    else
      @total = @normal
    end
  end
  def find_bill
    @bill = Bill.find(params[:id])
  end
  def bill_params
    params.require(:bill).permit(:total,:payed)
  end
end
