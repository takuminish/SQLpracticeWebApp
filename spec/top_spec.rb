# coding: utf-8
require './app'

describe 'topページのテスト' do
  def app
    SQLApplication
  end

  it 'トップページにアクセスできる' do
    get '/'
    expect(last_response).to be_ok
  end
end
