require 'rails_helper'

describe Job do
  context 'validations' do
    context 'presence_of' do
      it { expect(subject).to validate_presence_of(:title) }
      it { expect(subject).to validate_presence_of(:description) }
      it { expect(subject).to validate_presence_of(:email) }
      it { expect(subject).to validate_presence_of(:company) }
    end

    context 'format_of' do
      it { expect(subject).to allow_value('me@email.com').for(:email) }
      it { expect(subject).not_to allow_value('m@e.com').for(:email) }
      it { expect(subject).to allow_value('http://www.site.com').for(:website) }
      it { expect(subject).not_to allow_value('site.com').for(:website) }
      it { expect(subject).to allow_value('http://www.site.com').for(:url) }
      it { expect(subject).not_to allow_value('site.com').for(:url) }
    end
  end

  context 'when job is valid' do
    subject(:job) { build(:job) }
    it { expect(job).to be_valid }
  end

  context 'when job is not valid' do
    subject(:job) { build(:job, email: 'm@e.com') }
    it { expect(job).not_to be_valid }
  end

  describe '#contract_type_label' do
    subject(:job) do
      build(:job, contract_type: contract_type).contract_type_label
    end

    context 'Not Speficied' do
      let(:contract_type) { 0 }

      it { is_expected.to eq 'Não Especificado' }
    end

    context 'CLT' do
      let(:contract_type) { 1 }

      it { is_expected.to eq 'CLT' }
    end

    context 'PJ' do
      let(:contract_type) { 2 }

      it { is_expected.to eq 'PJ' }
    end
  end
end
