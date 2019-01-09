# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  context 'when testing associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:category) }
  end
end
