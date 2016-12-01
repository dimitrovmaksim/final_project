require 'rails_helper'

RSpec.describe Comment, :type => :model do
  subject {
    described_class.new(id: '1', commenter: nil, body: 'comment',created_at: DateTime.now, updated_at: DateTime.now, article_id: '1', user_id: '1')
  }

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end

  it "is not valid without a body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "has body with less than 3 characters" do
    subject.body = 'ab'
    expect(subject).to_not be_valid
  end

end
