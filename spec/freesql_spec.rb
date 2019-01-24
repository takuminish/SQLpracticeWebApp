# coding: utf-8
require './app'

describe 'freesqlページのテスト' do
  def app
    SQLApplication
  end

  it 'トップページにアクセスできる' do
    get '/freesql'
    expect(last_response).to be_ok
  end
end
