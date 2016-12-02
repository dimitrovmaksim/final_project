require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(email: 'maxi@abv.bg', password: '123456', user_name: 'Maxi', admin: true)
  }
  let(:user) { User.create(email: 'maksim@abv.bg', password: '123456', user_name: 'Maxim', admin: true) }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should have_many(:comments) }
    it { should have_many(:articles) }
  end

  it "has invalid email" do
    subject.email = 'maxi.abv.bg'
    expect(subject).to_not be_valid
  end

  it "has unique email" do
    subject.email = 'max@abv.bg'
    expect(subject).to_not be_valid
  end

  it "cannot have blank email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "cannot have blank user name" do
    subject.user_name = nil
    expect(subject).to_not be_valid
  end

 it "does not have unique user name" do
    subject.user_name = "Maxim"
    expect(subject).to_not be_valid
  end

  it "cannot have user name with less than 3 characters" do
    subject.user_name = "Ma"
    expect(subject).to_not be_valid
  end

  it "cannot have blank password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "cannot have invalid password" do
    subject.password = "12345"
    expect(subject).to_not be_valid
  end
end

