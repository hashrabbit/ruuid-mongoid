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
end
