# coding: utf-8
require './app'

describe 'problems一覧ページのテスト' do
  def app
    SQLApplication
  end

  it 'トップページにアクセスできる' do
    get '/problems'
    expect(last_response).to be_ok
  end
end
