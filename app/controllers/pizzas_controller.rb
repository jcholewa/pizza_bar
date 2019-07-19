class PizzasController < ApplicationController
  respond_to? :json 
  def index
    @pizzas = Pizza.all
    if @pizzas.empty?
      render json: [], status: :ok
    else
      render json: @pizzas.as_json(:only => [ :id, :name, :ingredients ]), status: :success
    end
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      render json: @pizza, status: :created
    else
      render json: @pizza.errors, status: :unprocessable_entity
    end
  end

  private

  def pizza_params
    params.require(:pizza).permit(:name, :ingredients => [])
  end
end