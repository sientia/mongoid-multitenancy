require "spec_helper"

describe 'Index Options' do

  let(:klass) do
    Class.new do
      include Mongoid::Multitenancy::Document
    end
  end

  let(:index) { {title: 1}}

  before do
    klass.tenant_field = :client_id
  end

  describe '#index_for_options' do
    context 'without multitenancy option' do
      it 'adds the tenant field index by default' do
        options = nil
        expect(klass.index_spec_for_options(index, options)).to eq({client_id: 1, title: 1})
      end
    end

    context 'with enabled multitenancy option' do
      it 'adds the tenant field index to the compound' do
        options = {multitenancy: true}
        expect(klass.index_spec_for_options(index, options)).to eq({client_id: 1, title: 1})
      end
    end

    context 'with disabled multitenancy option' do
      it 'omits the tenant field from the index' do
        options = {multitenancy: false}
        expect(klass.index_spec_for_options(index, options)).to eq({title: 1})
      end
    end
  end
end
