require 'rails_helper'

module HttpUrlValidatorDouble
  class Validatable
    include ActiveModel::Validations
    attr_accessor :url
    validates :url, http_url: true
  end
end

RSpec.describe HttpUrlValidator do

  subject{ HttpUrlValidatorDouble::Validatable.new }

  it 'is valid without a value' do
    subject.url = nil
    expect(subject).to be_valid
    subject.url = ' '
    expect(subject).to be_valid
  end
  it 'is valid with a http url' do
    subject.url = 'http://www.test.com'
    expect(subject).to be_valid
  end
  it 'is valid with a https url' do
    subject.url = 'https://www.test.com'
    expect(subject).to be_valid
  end
  it 'is valid with an utf8 url' do
    subject.url = 'http://en.wikipedia.org/wiki/.рф'
    expect(subject).to be_valid
    subject.url = 'https://кц.рф'
    expect(subject).to be_valid
  end
  it 'is valid with a really long http url' do
    subject.url = "http://www.example.com/l#{'o'*4000}ng"
    expect(subject).to be_valid
  end
  it 'is invalid with a ftp url' do
    subject.url = 'ftp://www.test.com'
    expect(subject).to be_invalid
    expect(subject.errors[:url].size).to eq(1)
  end
  it 'is invalid with javascript: urls' do
    subject.url = 'javascript:alert("boom")'
    expect(subject).to be_invalid
  end
  it 'rejects hosts without a top level domain' do
    subject.url = 'http://localhost'
    expect(subject).to be_invalid
    expect(subject.errors[:url].size).to eq(1)

    subject.url = 'https://localhost'
    expect(subject).to be_invalid
    expect(subject.errors[:url].size).to eq(1)

    subject.url = 'forgotdotcom'
    expect(subject).to be_invalid
    expect(subject.errors[:url].size).to eq(1)
  end
end

