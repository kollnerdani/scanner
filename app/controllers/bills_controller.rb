class BillsController < ApplicationController
  before_action :find_bill, only:[:show,:update]
  def index
    #@bills = Bill.select{|bill| !bill.bill_elements.empty? && bill.payed}
    @bills = Bill.where(payed:true)
    #@unfinished_bills = Bill.select{|bill| bill.bill_elements.empty? || !bill.payed}
    @unfinished_bills = Bill.where.not(payed:true)
  end
  def show
    @bill_element = BillElement.new
    @element_sales = ElementSale.all
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
    @bill.total = [@normal.to_f, @total_sale.to_f, @total]
    if @bill.update(bill_params)
      redirect_to bills_path
    else
      redirect_to bill_path(@bill)
    end
  end
private
  def total
    #updating bill elements to "update" bill in bill show with total price, and prepare "total" on bill update to store immutable elements
    #to count total price without "sales"
    @normal = @bill.bill_elements.map{|be| be.element.price}.sum
    #to prepare bill elements with sales condition
    @sale = {}
    #order elements by codes  with amount of articles
    @bill.bill_elements.map{|be| be.element.id}.group_by(&:itself).each do |key, value|
      #calculating sales
      if !Element.find(key).element_sales.empty?
        #calculate amount of sales by element_sale conditions for example 1 for 0.50 3 for 1.20
        sale = (value.count/Element.find(key).element_sales.last.quantity) * Element.find(key).element_sales.last.sale_price
        #articles over or under conditions
        rest = (value.count%Element.find(key).element_sales.last.quantity) * Element.find(key).price
      else
        #articles(elements) without sales condition
        sale = 0
        rest = value.count * Element.find(key).price
      end
      #order elements by codes with exact price and sale and amount
      @sale[key] = [Element.find(key).code, Element.find(key).element_sales.empty?, value.count, sale + rest]
    end
    #calculating total sale
    @total_sale = @normal - @sale.map{|key, value| value[3]}.sum
    #calculating total
    @total = @sale.map{|key, value| value[3]}.sum
  end

  def find_bill
    @bill = Bill.find(params[:id])
  end
  def bill_params
    params.require(:bill).permit(:total,:payed)
  end
end
