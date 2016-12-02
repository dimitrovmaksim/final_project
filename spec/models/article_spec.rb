require 'rails_helper'

RSpec.describe Article, :type => :model do
  subject {
    described_class.new(title: 'anything', text: 'anything', user: user, image_url: 'http://www.w3schools.com/css/trolltunga.jpg')
  }
  let(:user) { User.create(email: 'muki@abv.bg', password: '123456', user_name: 'Maks', admin: true) }

  describe "#tag_list" do
    let!(:article) { article = Article.create(title: 'anything', text: 'anything', user: user) }

    it "constructs a tag list" do
      article.tags << Tag.create(name: 'anything')
      article.tags << Tag.create(name: 'anything2')
      expect(article.tag_list).to eq("anything, anything2")
    end

    it "constructs a tag list with only one tag" do
      article.tags << Tag.create(name: 'anything')
      expect(article.tag_list).to eq("anything")
    end

    it "constructs a tag list without tags" do
      expect(article.tag_list).to eq("")
    end
  end

  describe "#tag_list=" do
    let!(:article) { Article.create(title: 'anything', text: 'anything', user: user) }

    it "shows unique tags count" do
      article.tag_list = 'tag, tag1, tag, tag2, tag3, tag4, tag1'
      expect(article.tags.count).to eq(5)
    end

    it "should eliminate extra space" do
      article.tag_list = 'tag,  tag1'
      expect(article.tags[1].name).to eq('tag1')
    end

    it "should eliminate two extra spaces" do
      article.tag_list = 'tag,   tag1'
      expect(article.tags[1].name).to eq('tag1')
    end

    it "should eliminate multiple extra spaces" do
      article.tag_list = 'tag,          tag1'
      expect(article.tags[1].name).to eq('tag1')
    end

    it "should remove blank tag" do
      article.tag_list = 'tag,,tag1'
      expect(article.tags[1].name).to eq('tag1')
    end

    it "should remove multiple blank tags" do
      article.tag_list = 'tag,,,,,,,tag1'
      expect(article.tags[1].name).to eq('tag1')
    end
  end

  describe ".search" do
    let!(:article) { Article.create(title: 'Take your chances', text: 'Do not give up', user: user) }
    let!(:article1) { Article.create(title: 'Do not let chances go to waste', text: 'Everything is important and has a value', user: user) }
    let!(:article2) { Article.create(title: 'I run out of ideas for titles', text: 'And for the article body too', user: user) }
    let!(:article3) { Article.create(title: 'One more article to go', text: 'I think this is enough', user: user) }

    it "should search for article title" do
     articles = Article.search('chances')
     expect(articles.count).to eq(2)
    end

    it "should search for article body" do
     articles = Article.search('enough')
     expect(articles.count).to eq(1)
    end

    it "should find articles by title and body" do
     articles = Article.search('article')
     expect(articles.count).to eq(2)
    end

    it "should't find anything" do
     articles = Article.search('calculator')
     expect(articles.count).to eq(0)
    end
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:taggings) }
    it { should have_many(:tags) }
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "title has less than 5 characters" do
    subject.title = 'any'
    expect(subject).to_not be_valid
  end

  it "has invalid image format" do
    subject.image_url = 'http://www.w3schools.com/css/trolltunga.doc'
    expect(subject).to_not be_valid
  end
end
