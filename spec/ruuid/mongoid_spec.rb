require 'spec_helper'

describe RUUID::Mongoid do
  it 'adds :uuid type mapping to Mongoid' do
    expect(Mongoid::Fields::TYPE_MAPPINGS[:uuid]).to eq(RUUID::UUID)
  end

  describe '.included' do
    let(:document) do
      Artist.new
    end

    let(:fields) do
      Artist.fields
    end

    it 'overwrites _id with RUUID::UUID' do
      expect(fields['_id'].type).to eq(RUUID::UUID)
    end

    it 'aliases id to _id' do
      expect(document.id).to eq(document._id)
    end
  end

  context 'when document instantiated' do
    let(:document) do
      Album.new
    end

    it 'generates id field' do
      expect(document.id).not_to be_nil
    end
  end

  describe 'finding a document by ID' do
    shared_examples 'a successful find' do
      let!(:document) do
        Album.create
      end

      subject(:found) do
        Album.find(id)
      end

      it 'successfully finds the document' do
        expect(found).to eq(document)
      end
    end

    context 'when ID is RUUID::UUID object' do
      let(:id) do
        document.id
      end

      it_behaves_like 'a successful find'
    end

    context 'when ID is stringified, canonical UUID' do
      let(:id) do
        document.id.to_s
      end

      it_behaves_like 'a successful find'
    end

    context 'when ID is stringified, compact UUID' do
      let(:id) do
        document.id.to_s(:compact)
      end

      it_behaves_like 'a successful find'
    end

    context 'when ID is binary UUID' do
      let(:id) do
        document.id.data
      end

      it_behaves_like 'a successful find'
    end

    context 'when ID is malformed' do
      it 'raises standard Mongoid::Errors::DocumentNotFound error' do
        expect {
          Album.find('bacon')
        }.to raise_error(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end
