# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  image      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when it is valid' do
    let(:user) { build :user }

    it 'should respond to email' do
      expect(user).to respond_to :email
    end

    it 'should respond to image' do
      expect(user).to respond_to :image
    end
  end

  context 'when an attribute is not present' do
    let(:user_with_no_email) { build :user, email: nil }
    let(:user_with_no_image) { build :user, image: nil }

    it 'should not permit absence of an email' do
      expect(user_with_no_email).to_not be_valid
    end

    it 'should not permit absence of an image' do
      expect(user_with_no_image).to_not be_valid
    end
  end

  context 'given different email scenarios' do
    let(:user) { build :user }

    valid_emails = ['foo@bar.baz', 'ignacio@acid.cl']
    invalid_emails = ['foo', 'foo@', 'foo@bar', '@bar']

    it 'should permit valid email formats' do
      valid_emails.each do |email|
        user.email = email
        expect(user).to be_valid
      end
    end

    it 'should not permit invalid email formats' do
      invalid_emails.each do |email|
        user.email = email
        expect(user).to_not be_valid
      end
    end
  end

  context 'when a user with the same email already exists' do
    let(:user) { build :user }

    before { FactoryGirl.create(:user) }

    it 'should not let the second one be valid' do
      expect(user).to_not be_valid
    end
  end
end
