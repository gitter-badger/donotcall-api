require 'check_numbers'

class ListQueriesController < ApplicationController

  def index
    render :new
  end

  def new
  end

  def create
    @results = CheckNumbers.new( query_params_transformed ).perform
    render :new
  end


  protected

    def parse_number_params
      query_key = "numbers"
      query_params
        .select { |key| query_key == key }
        .map { |key, value| {key => parse_numbers(value)} }
        .reduce(:merge)
    end

    def query_params
      params.permit(:numbers)
    end

    def query_params_transformed
      query_params.merge parse_number_params
    end

    def parse_numbers(input_str)
      input_str.split(",").map(&:strip)
    end 
end
