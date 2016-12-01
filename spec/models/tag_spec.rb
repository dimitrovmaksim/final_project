require 'rails_helper'

RSpec.describe Tag, :type => :model do

  describe "Associations" do
    it { should have_many(:taggings) }
    it { should have_many(:articles) }
  end
end
