require 'rails_helper'
require 'check_numbers'

RSpec.describe CheckNumbers do

  let(:valid_params) { {numbers: ['7248380940', '7178345564'], extras: {}} }

  describe '#perform' do
    context 'valid parameters' do
      it 'returns a results array' do
        results = CheckNumbers.new(valid_params).perform      
        expect(results).to be_instance_of(Array)
      end

      context 'results' do
        it  'each result is a query object' do
          results = CheckNumbers.new(valid_params).perform
          results.each {|result| expect(result).to be_instance_of(ListQuery) }
        end
      end
    end

    context 'errors' do
      it 'fails when numbers input not array' do
        expect(CheckNumbers.new(numbers: nil, extras: {}).perform).to eq(false)
      end

      it 'fails when numbers empty' do
        expect(CheckNumbers.new(numbers: [], extras: {}).perform).to eq(false)
      end
    end
  end
end
