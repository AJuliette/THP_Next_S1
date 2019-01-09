# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id          :bigint(8)        not null, primary key
#  item_id     :bigint(8)
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  context 'when testing associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:category) }
  end
end
