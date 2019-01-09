# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Category' do
    context 'when testing validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:description) }
    end

    context 'when testing associations' do
      it { is_expected.to have_many(:items) }
    end
  end
end
