require 'rails_helper'

user = User.create(email: 'max@abv.bg', password: '123456', user_name: 'Maxim')

RSpec.describe User, :type => :model do
  subject {
    described_class.new(id: '2', email: 'maxi@abv.bg', password: '123456',created_at: DateTime.now, updated_at: DateTime.now, user_name: 'Maxi', admin: true)
  }


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

  it "has blank email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "has blank user name" do
    subject.user_name = nil
    expect(subject).to_not be_valid
  end

 it "has unique user name" do
    subject.user_name = "Maxim"
    expect(subject).to_not be_valid
  end

  it "has user name with 3 or less characters" do
    subject.user_name = "Ma"
    expect(subject).to_not be_valid
  end

  it "has blank password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "has invalid password" do
    subject.password = "12345"
    expect(subject).to_not be_valid
  end
end

