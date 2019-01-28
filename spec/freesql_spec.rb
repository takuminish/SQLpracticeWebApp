# coding: utf-8
require './app'

describe 'freesqlページのテスト' do
  def app
    SQLApplication
  end

  it '/freesqlにアクセスできる' do
    get '/freesql'
    p last_response.title
    expect(last_response).to be_ok
  end

  
end
