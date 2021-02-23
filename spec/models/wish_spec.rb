# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end

  describe 'validation: name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
  end

  describe 'validation: star' do
    it { is_expected.to validate_presence_of(:star) }
    it { is_expected.to validate_numericality_of(:star).is_greater_than(0).is_less_than(6).only_integer }
  end

  describe 'validate: status' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to define_enum_for(:status).with_values(%i[wish bougth]) }
  end

  describe 'default_scope: order(star: :desc)' do
    let!(:wish_1) { create(:wish, star: 1) }
    let!(:wish_2) { create(:wish, star: 2) }
    let!(:wish_3) { create(:wish, star: 3) }

    it 'order(star: :desc)' do
      wishes = Wish.all
      expect(wishes[0].id).to eq wish_3.id
      expect(wishes[1].id).to eq wish_2.id
      expect(wishes[2].id).to eq wish_1.id
    end
  end
end
