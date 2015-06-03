require 'spec_helper'

describe RUUID::Mongoid::Extensions::UUID do
  let(:uuid) do
    RUUID::UUID.new
  end

  describe '.demongoize' do
    subject(:uuid) do
      RUUID::UUID.demongoize(object)
    end

    context 'when BSON::Binary' do
      let(:object) do
        BSON::Binary.new(
          "\xf2\xebn\xc0\xca\xe0f\xbe\xa1\x8f\xc0\xe9j\x1d\b\xfa", :uuid
        )
      end

      it 'returns RUUID::UUID representation' do
        expect(uuid).to eq(RUUID::UUID.parse('f2eb6ec0-cae0-66be-a18f-c0e96a1d08fa'))
      end
    end

    context 'when canonical format string' do
      let(:object) do
        '1fffd2ba-fce1-4319-a443-25dd588e61dd'
      end

      it 'returns RUUID::UUID representation' do
        expect(uuid.to_s).to eq(object)
      end
    end

    context 'when compact format string' do
      let(:object) do
        'bc4a22f2a65048ffbc4daf169b790c0f'
      end

      it 'returns RUUID::UUID representation' do
        expect(uuid.to_s(:compact)).to eq(object)
      end
    end

    context 'when nil' do
      let(:object) do
        nil
      end

      it 'returns nil' do
        expect(uuid).to be_nil
      end
    end
  end

  %i[evolve mongoize].each do |method_name|
    describe ".#{method_name}" do
      subject(:mongoized) do
        RUUID::UUID.send(method_name, uuid)
      end

      context 'when object nil' do
        let(:uuid) do
          nil
        end

        it 'returns nil' do
          expect(mongoized).to be_nil
        end
      end

      context 'when object not nil' do
        it 'returns BSON::Binary with UUID type and data' do
          expect(mongoized).to be_a(BSON::Binary)
          expect(mongoized.data).to eq(uuid.data)
          expect(mongoized.type).to eq(:uuid)
        end
      end
    end
  end

  describe '#mongoize' do
    subject(:mongoized) do
      uuid.mongoize
    end

    it 'returns BSON::Binary with UUID type and data' do
      expect(mongoized).to be_a(BSON::Binary)
      expect(mongoized.data).to eq(uuid.data)
      expect(mongoized.type).to eq(:uuid)
    end
  end
end
